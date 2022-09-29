import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetAdvertImagesAction extends ReduxAction<AppState> {
  final String? advertId;

  GetAdvertImagesAction({this.advertId});

  @override
  Future<AppState?> reduce() async {
    final String id = advertId ?? state.activeAd!.id;

    final List<String> imageUrls = [];

    try {
      final ListResult result = await Amplify.Storage.list(path: "adverts/$id");
      final List<StorageItem> items = result.items;

      for (StorageItem item in items) {
        final imageUrl = await Amplify.Storage.getUrl(key: item.key);
        imageUrls.add(imageUrl.url);
      }
    } on StorageException catch (e) {
      debugPrint('Error listing items: $e');
    }

    return state.copy(activeAd: state.activeAd!.copy(images: imageUrls));
  }
}
