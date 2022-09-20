import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

class GetPdfAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    try {
      final String key = state.activeBid!.quote!;

      // checking if image exists
      final ListResult result = await Amplify.Storage.list(path: key);
      if (result.items.isEmpty) return state.copy(pdfFile: null);

      final GetUrlResult pdfFile = await Amplify.Storage.getUrl(key: key);

      final http.Response responseData = await http.get(Uri.parse(pdfFile.url));
      Uint8List file = responseData.bodyBytes;

      return state.copy(pdfFile: file);
    } on StorageException catch (e) {
      debugPrint('Error downloading file: $e');
      return null;
    }
  }
}
