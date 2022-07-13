import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/adverts/create_advert_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/floating_button.dart';

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
          backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //*******************APP BAR WIDGET*********************//
                const AppBarWidget(title: "Create a Job"),
                //********************************************************//

                //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER***//

                //title
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

                //description
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

                StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) => Column(
                    children: [
                      const Padding(padding: EdgeInsets.all(50)),

                      //*********CREATE JOB BUTTON******************//
                      ButtonWidget(
                        text: "Create Job",
                        function: () => vm.dispatchCreateAdvertActions(
                            store.state.user!.id,
                            titleController.value.text,
                            descrController.value.text),
                      ),
                      //********************************************//
                      const Padding(padding: EdgeInsets.all(5)),

                      //************DISCARD BUTTON*****************//
                      ButtonWidget(
                          text: "Discard", color: "dark", function: vm.popPage)
                      //********************************************//
                    ],
                  ),
                ),
              ],
            ),
          ),
          //************************NAVBAR***********************/
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

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
        popPage: () => dispatch(NavigateAction.pop()),
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
  final VoidCallback popPage;

  _ViewModel({
    required this.dispatchCreateAdvertActions,
    required this.popPage,
  }); // implementinf hashcode
}
