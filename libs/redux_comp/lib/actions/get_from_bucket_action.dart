import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux_comp/models/bucket_model.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetFromBucketAction extends ReduxAction<AppState> {
  FileType fileType;
  String advertId;

  GetFromBucketAction(this.advertId, this.fileType);

  @override
  Future<AppState?> reduce() async {
    final documents = getApplicationDocumentsDirectory();

    try {
      final ListResult items;

      switch (fileType) {
        case FileType.job:
          items = await Amplify.Storage.list(path: "adverts/$advertId");
          break;
        case FileType.quote:
          items = await Amplify.Storage.list(path: "quotes/$advertId");
          break;
        case FileType.profile:
          throw "Rather use GetProfileAction";
      }

      final documentsDir = await documents;

      items.items.removeAt(0);
      final List<String> keys = items.items.map((e) => e.key).toList();

      for (String key in keys) {
        final String filepath =
            "${documentsDir.path}/${key.replaceAll("/", "-")}";

        final file = File(filepath);

        /* final result = */ await Amplify.Storage.downloadFile(
          key: key,
          local: file,
          onProgress: (progress) {
            debugPrint(
                'Fraction completed: ${progress.getFractionCompleted()}');
          },
        );
      }
    } on StorageException catch (e) {
      debugPrint('Error downloading file: $e');
    }

    return null;
  }
}
