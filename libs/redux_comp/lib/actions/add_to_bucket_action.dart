import 'dart:io';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

// enum to show what kind of upload
enum FileType {
  profile,
  job,
  quote,
}

// Action to upload files to an s3 bucket
class AddToBucketAction extends ReduxAction<AppState> {
  final FileType fileType; // type of file
  final File file; // file to upload
  final String? advertId;

  AddToBucketAction(
    this.fileType,
    this.file, {
    this.advertId,
  });

  @override
  Future<AppState?> reduce() async {
    final String key;

    switch (fileType) {
      case FileType.profile:
        key = "profile";
        break;
      case FileType.job: // happens if consumer is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is job.";
        }
        String uuid = const Uuid().v1(); // unique id of image
        key = "$advertId!/$uuid";
        break;
      case FileType.quote: // happens when tradesman is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is quote.";
        }
        key = "quotes/$advertId!";
        break;
    }

    // Set the access level to `protected` for the current user
    // Note: A user must be logged in through Cognito Auth
    // for this to work.
    final uploadOptions = S3UploadFileOptions(
      accessLevel: StorageAccessLevel.protected,
    );

    // AuthUser temp = await Amplify.Auth.getCurrentUser();

    // Upload the file to S3 with protected access
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: file,
          key: key,
          options: uploadOptions,
          onProgress: (progress) {
            debugPrint(
                'Fraction completed: ${progress.getFractionCompleted()}');
          });
      debugPrint('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      debugPrint('Error uploading protected file: $e');
    }

    return null;
  }
}
