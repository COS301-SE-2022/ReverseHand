import 'dart:io';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:path_provider/path_provider.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AddToBucketAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // Create a dummy file
    const exampleString = 'Example file contents';
    final tempDir = await getTemporaryDirectory();
    final exampleFile = File('${tempDir.path}/example.txt')
      ..createSync()
      ..writeAsStringSync(exampleString);

    // Set the access level to `protected` for the current user
    // Note: A user must be logged in through Cognito Auth
    // for this to work.
    final uploadOptions = S3UploadFileOptions(
      accessLevel: StorageAccessLevel.protected,
    );

    // Upload the file to S3 with protected access
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
          local: exampleFile,
          key: 'ExampleKey',
          options: uploadOptions,
          onProgress: (progress) {
            print('Fraction completed: ${progress.getFractionCompleted()}');
          });
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading protected file: $e');
    }

    return null;
  }
}
