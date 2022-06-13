import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/actions/create_advert_action.dart';
import 'package:redux_comp/redux_comp.dart';

class CreateNewAdvertPage extends StatelessWidget {
  final Store<AppState> store;

  CreateNewAdvertPage({Key? key, required this.store}) : super(key: key);

  final titleController = TextEditingController();
  final descrController = TextEditingController();

  //*****Calls method to create a new job*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          backgroundColor:
              const Color.fromRGBO(18, 26, 34, 1), //background colour
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //*******************PADDING FROM TOP*********************//
                const Padding(padding: EdgeInsets.only(top: 50)),
                //********************************************************//

                //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
                  child: TextFieldWidget(
                    label: "Title",
                    obscure: false,
                    controller: titleController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: TextFieldWidget(
                    label: "Description",
                    obscure: false,
                    controller: descrController,
                  ),
                ),
                //*************************************************//

                //**********BACKBUTTON**************************//
                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) => BackButton(
                      color: Colors.white, onPressed: vm.pushConsumerListings),
                ),
                //************************************************//

                //***********PADDING BETWEEN BACK BUTTON AND CREATE JOB BUTTON*************//
                const Padding(padding: EdgeInsets.all(10)),
                //********************************************************//

                //**********CREATE NEW JOB BUTTON*****************//
                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) =>
                      ElevatedButton(
                    onPressed: () => vm.dispatchCreateAdvertActions(
                        store.state.user!.id,
                        titleController.value.text,
                        descrController.value.text),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black,
                      elevation: 9,
                      textStyle: const TextStyle(fontSize: 20),
                      minimumSize: const Size(180, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                    ),
                    child: const Text("Add new job"),
                  ),
                )
                //*************************************************??
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, CreateNewAdvertPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushConsumerListings: () =>
            dispatch(NavigateAction.pushNamed('/consumer')),
        dispatchCreateAdvertActions:
            (String customerId, String title, String? description) => dispatch(
          CreateAdvertAction(customerId, title, description: description),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String, String?) dispatchCreateAdvertActions;
  final VoidCallback pushConsumerListings;

  _ViewModel({
    required this.dispatchCreateAdvertActions,
    required this.pushConsumerListings,
  }); // implementinf hashcode
}
