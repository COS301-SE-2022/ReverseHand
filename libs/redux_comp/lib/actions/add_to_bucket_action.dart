import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/bucket_model.dart';
import 'user/get_profile_photo_action.dart';

// Action to upload files to an s3 bucket
class AddToBucketAction extends ReduxAction<AppState> {
  final FileType fileType; // type of file
  final File? file; // file to upload
  final List<File>? files; // files to upload
  // cant have file and files
  final String? advertId;

  AddToBucketAction({
    required this.fileType,
    this.file,
    this.files,
    this.advertId,
  });

  @override
  Future<AppState?> reduce() async {
    if (file == null && files == null) {
      throw "file and files cannot both be null";
    }

    if (file != null && files != null) {
      throw "either file or files must be null";
    }

    final String? advertId = this.advertId ?? state.activeAd?.id;

    final String key;
    final List<String> keys = [];

    switch (fileType) {
      // <bucket>/public/profiles/<user_id>
      case FileType.profile:
        key = "profiles/${state.userDetails.id}";
        break;
      // <bucket>/adverts/<advert_id>/<uuid>
      case FileType.job: // happens if consumer is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is job.";
        }
        if (file != null) {
          String uuid = const Uuid().v1(); // unique id of image
          key = "adverts/$advertId!/$uuid";
        } else {
          key = "";
          for (File _ in files!) {
            String uuid = const Uuid().v1(); // unique id of image
            print("UUID: $uuid");
            keys.add("adverts/$advertId!/$uuid");
          }
        }

        break;
      // <bucket>/quotes/<advert_id>/<user_id>
      case FileType.quote: // happens when tradesman is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is quote.";
        }
        key = "quotes/$advertId/${state.userDetails.id}";
        break;
    }

    // Upload the file to S3 with protected access
    try {
      if (file != null) {
        final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file!,
          key: key,
          onProgress: (progress) {
            debugPrint(
                'Fraction completed: ${progress.getFractionCompleted()}');
          },
        );
        debugPrint('Successfully uploaded file: ${result.key}');
      } else {
        for (int i = 0; i < files!.length; i++) {
          /* final UploadFileResult result = await */ Amplify.Storage
              .uploadFile(
            local: files![i],
            key: keys[i],
            onProgress: (progress) {
              debugPrint(
                  'Fraction completed: ${progress.getFractionCompleted()}');
            },
          );
          // debugPrint('Successfully uploaded file: ${result.key}');
        }
      }

      switch (fileType) {
        case FileType.profile:
          final imageUrl = await Amplify.Storage.getUrl(key: key);
          return state.copy(
              userDetails: state.userDetails.copy(profileImage: imageUrl.url));
        case FileType.job: // happens if consumer is logged in
          break;
        case FileType.quote: // happens when tradesman is logged in
          break;
      }

      return null;
    } on StorageException catch (e) {
      debugPrint('Error uploading protected file: $e');
      return null;
    }
  }

  @override
  void after() {
    if (fileType == FileType.profile) dispatch(GetProfilePhotoAction());
  }
}
