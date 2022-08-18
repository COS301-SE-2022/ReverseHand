import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:redux_comp/models/bucket_model.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetFromBucketAction extends ReduxAction<AppState> {
  final String? userId;
  final String? advertId;
  final FileType fileType;

  GetFromBucketAction({required this.fileType, this.advertId, this.userId});

  @override
  Future<AppState?> reduce() async {
    final documentsDir = await getApplicationDocumentsDirectory();

    String key;

    switch (fileType) {
      // <bucket>/public/profiles/<user_id>
      case FileType.profile:
        if (userId == null) {
          throw "User ID cannot be null if FileType is profile.";
        }
        key = "profiles/$userId";
        break;
      // <bucket>/adverts/<advert_id>/<uuid>
      case FileType.job: // happens if consumer is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is job.";
        }
        key = "adverts/$advertId!/";
        break;
      // <bucket>/quotes/<advert_id>/<user_id>
      case FileType.quote: // happens when tradesman is logged in
        if (advertId == null) {
          throw "Advert ID cannot be null if FileType is quote.";
        }
        key = "quotes/$advertId!";
        break;
    }
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
  }
}
