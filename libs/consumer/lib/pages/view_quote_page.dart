import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:redux_comp/app_state.dart';

class ViewQuotePage extends StatelessWidget {
  final Store<AppState> store;

  const ViewQuotePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Tradesman Quote"),
                backgroundColor: Theme.of(context).primaryColorDark,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      // onPressed: () async {
                      //   await saveFile(widget.url, "sample.pdf");
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text(
                      //         'success',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   );
                      // },
                      onPressed: () {},
                      icon: const Icon(Icons.download_rounded),
                    ),
                  ),
                ],
              ),
              body: vm.file == null
                  ? null
                  : PDFView(
                      pdfData: vm.file,
                    ),
            );
          }),
    );
  }
}

//download file functionality
// void requestPersmission() async {
//   await PermissionHandler().requestPermissions([PermissionGroup.storage]);
// }

// Future<bool> saveFile(String url, String fileName) async {
//   try {
//     if (await _requestPermission(Permission.storage)) {
//       Directory? directory;
//       directory = await getExternalStorageDirectory();
//       String newPath = "";
//       List<String> paths = directory!.path.split("/");
//       for (int x = 1; x < paths.length; x++) {
//         String folder = paths[x];
//         if (folder != "Android") {
//           newPath += "/" + folder;
//         } else {
//           break;
//         }
//       }
//       newPath = newPath + "/PDF_Download";
//       directory = Directory(newPath);

//       File saveFile = File(directory.path + "/$fileName");
//       if (kDebugMode) {
//         print(saveFile.path);
//       }
//       if (!await directory.exists()) {
//         await directory.create(recursive: true);
//       }
//       if (await directory.exists()) {
//         await Dio().download(
//           url,
//           saveFile.path,
//         );
//       }
//     }
//     return true;
//   } catch (e) {
//     return false;
//   }
// }

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, ViewQuotePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        file: state.pdfFile,
      );
}

// view model
class _ViewModel extends Vm {
  final Uint8List? file;

  _ViewModel({
    required this.file,
  }) : super(equals: [file]);
}
