import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/app_state.dart'; 
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class ViewQuotePage extends StatelessWidget {
  final Store<AppState> store;

  const ViewQuotePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text("File Name here"),
        backgroundColor: Theme.of(context).primaryColorDark,
        actions: [
          Padding(padding: const EdgeInsets.only(right: 10),
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
            onPressed: () {  },
            icon: const Icon(Icons.download_rounded),
          ),
          ),
        ],
      ),
      body: const PDFView(
        filePath: "",
        // filePath: name,
      ),
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
class _Factory extends VmFactory<AppState, ViewQuotePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {
  _ViewModel(); 
}
