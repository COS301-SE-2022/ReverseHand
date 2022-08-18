import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetProfilePhotoAction extends ReduxAction<AppState> {
  final String userId;

  GetProfilePhotoAction(this.userId);

  @override
  Future<AppState?> reduce() async {
    final documentsDir = await getApplicationDocumentsDirectory();

    String key = "profiles/$userId";
    final String filepath = "${documentsDir.path}/${key.replaceAll("/", "-")}";

    final file = File(filepath);

    try {
      final result = await Amplify.Storage.downloadFile(
        key: key,
        local: file,
        onProgress: (progress) {
          print('Fraction completed: ${progress.getFractionCompleted()}');
        },
      );
      final contents = result.file.readAsStringSync();
      // Or you can reference the file that is created above
      // final contents = file.readAsStringSync();
      print('Downloaded contents: $contents');
    } on StorageException catch (e) {
      print('Error downloading file: $e');
    }

    return null;
  }
}
