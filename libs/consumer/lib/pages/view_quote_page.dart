import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:redux_comp/app_state.dart'; 

class ViewQuotePage extends StatelessWidget {
  final Store<AppState> store;

  const ViewQuotePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text("File"),
        actions: [
          IconButton(
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
        ],
      ),
      body: PDFView(
        // filePath: widget.file.path,
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ViewQuotePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {

  _ViewModel(); // implementinf hashcode
}
