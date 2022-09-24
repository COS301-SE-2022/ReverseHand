import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:redux_comp/actions/add_to_bucket_action.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/models/bucket_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';
import '../analytics_events/record_create_advert_action.dart';

// creates an advert
// requires the customerdId and a title the rest is optional
class CreateAdvertAction extends ReduxAction<AppState> {
  final String customerId;
  final String title;
  final String? description;
  final String type;
  final Domain domain;
  final List<File>? files; // files to upload

  CreateAdvertAction(
    this.customerId,
    this.title,
    this.domain,
    this.type, {
    this.description,
    this.files,
  }); // Create...(id, title, description: desc)

  @override
  Future<AppState?> reduce() async {
    int fileCount = files?.length ?? 0;

    String graphQLDocument = '''mutation {
      createAdvert(customer_id: "$customerId", title: "$title", description: "$description", domain: ${domain.toString()}, type: "$type", images: $fileCount) {
        id
      }
    }''';

    final request = GraphQLRequest(
      document: graphQLDocument,
    );

    try {
      final response = await Amplify.API.mutate(request: request).response;
      final id = jsonDecode(response.data)['createAdvert']['id'];

      if (files != null) {
        dispatch(AddToBucketAction(
            fileType: FileType.job, advertId: id, files: files));
      }

      dispatch(RecordCreateAdvertAction(
          city: domain.city, province: domain.province, name: title));

      return null;
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null; // on error does not modify appstate
    } catch (e) {
      debugPrint(e.toString());
      return null; // on error does not modify appstate
    }
  }

  @override
  void before() => dispatch(WaitAction.add("create_advert"));

  @override
  void after() async {
    dispatch(ViewAdvertsAction());
    dispatch(NavigateAction.pushNamed("/consumer"));
    dispatch(WaitAction.remove("create_advert"));
  }
}
