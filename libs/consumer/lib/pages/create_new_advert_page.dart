import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/create_advert_action.dart';
import 'package:redux_comp/redux_comp.dart';

class CreateNewAdvertPage extends StatelessWidget {
  final Store<AppState> store;

  CreateNewAdvertPage({Key? key, required this.store}) : super(key: key);

  final titleController = TextEditingController();
  final descrController = TextEditingController();
  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  //*****Calls method to create a new job*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          resizeToAvoidBottomInset:
              false, //prevents floatingActionButton appearing above keyboard
          backgroundColor:
              const Color.fromRGBO(18, 26, 34, 1), //background colour
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //*******************APP BAR WIDGET*********************//
                const AppBarWidget(title: "Create a Job"),
                //********************************************************//

                //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                  child: TextFieldWidget(
                    label: "Title",
                    obscure: false,
                    min: 2,
                    controller: titleController,
                    initialVal: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                  child: TextFieldWidget(
                    label: "Description",
                    obscure: false,
                    min: 3,
                    controller: descrController,
                    initialVal: null,
                  ),
                ),
                //*************************************************//

                //*************STORECONNECTOR**********************//
                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) => Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(50)),

                      //*********CREATE JOB BUTTON******************//
                      ButtonWidget(
                        text: "CREATE JOB",
                        function: () => vm.dispatchCreateAdvertActions(
                            store.state.user!.id,
                            titleController.value.text,
                            descrController.value.text),
                      ),
                      //********************************************//
                      const Padding(padding: EdgeInsets.all(5)),

                      //************DISCARD BUTTON*****************//
                      ButtonWidget(
                          text: "DISCARD",
                          transparent: true,
                          function: vm.pushConsumerListings)
                      //********************************************//
                    ],
                  ),
                ),
                //********************************************************//
              ],
            ),
          ),
          //*******************ADD BUTTON********************//
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //*************************************************//

          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*****************************************************/
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
          CreateAdvertAction(customerId, title, "Pretoria", "Plumbing",
              description: description),
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
