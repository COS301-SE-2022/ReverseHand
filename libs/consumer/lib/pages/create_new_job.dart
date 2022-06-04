import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_create_new_job.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';

class CreateNewJob extends StatelessWidget {
  final Store<AppState> store;
  const CreateNewJob({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: JobCreation(store: store),
        theme: CustomTheme.darkTheme,
      ),
    );
  }
}
