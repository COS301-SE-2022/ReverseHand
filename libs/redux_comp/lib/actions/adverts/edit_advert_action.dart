import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/actions/add_to_bucket_action.dart';
import 'package:redux_comp/actions/adverts/get_advert_images_action.dart';
import 'package:redux_comp/actions/remove_files_from_bucket_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bucket_model.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class EditAdvertAction extends ReduxAction<AppState> {
  final String advertId;
  final String? description;
  final String? type;
  final Domain? domain;
  final String? title;
  final List<File>? files; // files to upload

  EditAdvertAction({
    required this.advertId,
    this.description,
    this.type,
    this.domain,
    this.title,
    this.files,
  });

  @override
  Future<AppState?> reduce() async {
    if (files != null) {
      dispatch(RemoveFilesFromBucketAction());
      dispatch(
        AddToBucketAction(
          fileType: FileType.job,
          advertId: state.activeAd!.id,
          files: files,
        ),
      );
    }

    int fileCount = files?.length ?? 0;

    String graphQLDocument = '''mutation { 
      editAdvert(ad_id: "$advertId",title: "$title",description: "$description", domain: ${domain.toString()}, images: $fileCount){
        id
      }
    } ''';

    final request = GraphQLRequest(document: graphQLDocument);
    //commented cause it was unused
    dynamic response = await Amplify.API.mutate(request: request).response;

    if (response.errors.isNotEmpty) {
      switch (response.errors[0].message) {
        case "Advert contains bids":
          throw const UserException("", cause: ErrorType.advertContainsBids);
      }
    }

    List<AdvertModel> adverts = state.adverts;

    //get the advert being edited
    int adPos = adverts.indexWhere((element) => element.id == advertId);

    AdvertModel ad = adverts[adPos];
    adverts[adPos] = AdvertModel(
      id: ad.id,
      userId: ad.userId,
      title: title ?? ad.title,
      dateCreated: ad.dateCreated,
      description: description ?? ad.description,
      type: type ?? ad.type,
      domain: domain ?? ad.domain,
      imageCount: ad.imageCount,
    );

    return state.copy(
      activeAd: adverts[adPos],
      adverts: adverts,
    );
  }

  @override
  void before() => dispatch(WaitAction.add("edit_advert"));

  @override
  void after() async {
    dispatch(GetAdvertImagesAction());
    dispatch(NavigateAction.pop());
    dispatch(WaitAction.remove("edit_advert"));
  }

  // sends error messages to CustomWrapError
  @override
  Object wrapError(error) {
    return error;
  }
}
