import 'package:flutter/material.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class RemoveFilesFromBucketAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    try {
      final response =
          await Amplify.Storage.list(path: 'adverts/${state.activeAd!.id}');
      final items = response.items;

      for (StorageItem item in items) {
        final result = await Amplify.Storage.remove(key: item.key);
        debugPrint('Deleted file: ${result.key}');
      }
    } on StorageException catch (e) {
      debugPrint('Error deleting file: $e');
    }

    return null;
  }
}
