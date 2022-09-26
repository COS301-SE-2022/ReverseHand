import 'package:flutter/material.dart';
import 'package:redux_comp/models/chat/chat_model.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetProfilePhotoAction extends ReduxAction<AppState> {
  final String? userId; // if not null than assumed that viewing another user
  final ChatModel? chat; // to populate a chats user profile

  GetProfilePhotoAction({
    this.userId,
    this.chat,
  });

  @override
  Future<AppState?> reduce() async {
    final String userId = this.userId ??
        (chat != null ? chat!.otherUserId : state.userDetails.id);

    String key = "profiles/$userId";

    try {
      // checking if image exists
      final ListResult result = await Amplify.Storage.list(path: key);
      if (result.items.isEmpty) return null;

      final imageUrl = await Amplify.Storage.getUrl(key: key);

      if (this.userId != null) {
        return state.copy(
            otherUserDetails:
                state.otherUserDetails.copy(profileImage: imageUrl.url));
      } else if (chat != null) {
        final List<ChatModel> chats = state.chats;
        final int pos = chats.indexWhere(
          (element) => element.id == chat!.id,
        );

        chats[pos] = chat!.copy(image: imageUrl.url);

        return state.copy(chats: chats, change: !state.change);
      } else {
        return state.copy(
            userDetails: state.userDetails.copy(profileImage: imageUrl.url));
      }
    } on StorageException catch (e) {
      debugPrint('Error downloading file: $e');
      return null;
    }
  }
}
