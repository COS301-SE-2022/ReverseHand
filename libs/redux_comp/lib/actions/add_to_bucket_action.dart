import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../models/bucket_model.dart';

// files are stored as

// Action to upload files to an s3 bucket
class AddToBucketAction extends ReduxAction<AppState> {
  final FileType fileType; // type of file
  final File file; // file to upload
  final String? advertId;

  AddToBucketAction({
    required this.fileType,
    required this.file,
    this.advertId,
  });

  @override
  Future<AppState?> reduce() async {
    final String key;

    switch (fileType) {
      // <bucket>/public/profiles/<user_id>
      case FileType.profile:
        key = "profiles/${state.userDetails!.id}";
        break;
      // <bucket>/adverts/<advert_id>/<uuid>
      case FileType.job: // happens if consumer is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is job.";
        }
        String uuid = const Uuid().v1(); // unique id of image
        key = "adverts/$advertId!/$uuid";
        break;
      // <bucket>/quotes/<advert_id>/<user_id>
      case FileType.quote: // happens when tradesman is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is quote.";
        }
        key = "quotes/$advertId!";
        break;
    }

    // Upload the file to S3 with protected access
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          onProgress: (progress) {
            debugPrint(
                'Fraction completed: ${progress.getFractionCompleted()}');
          });
      debugPrint('Successfully uploaded file: ${result.key}');

      switch (fileType) {
        case FileType.profile:
          return state.copy(userProfileImage: file);
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
}
