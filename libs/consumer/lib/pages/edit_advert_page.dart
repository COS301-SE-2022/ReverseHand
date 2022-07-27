import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/adverts/edit_advert_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class EditAdvertPage extends StatelessWidget {
  final Store<AppState> store;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  EditAdvertPage({Key? key, required this.store}) : super(key: key);

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
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
               
                return Column(
                  children: <Widget>[
                    //*******************APP BAR WIDGET*********************//
                    const AppBarWidget(title: "EDIT JOB"),
                    //********************************************************//

                    //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                      child: TextFieldWidget(
                        initialVal: vm.advert.title,
                        label: "Title",
                        obscure: false,
                        min: 2,
                        controller: titleController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: TextFieldWidget(
                        initialVal: vm.advert.description,
                        label: "Description",
                        obscure: false,
                        min: 3,
                        controller: descriptionController,
                      ),
                    ),
                    //*************************************************//

                    StoreConnector<AppState, _ViewModel>(
                      vm: () => _Factory(this),
                      builder: (BuildContext context, _ViewModel vm) => Column(
                        children: [
                          const Padding(padding: EdgeInsets.all(50)),

                          //*********CREATE JOB BUTTON******************//
                          vm.loading
                              ? const LoadingWidget()
                              : ButtonWidget(
                                  text: "Save Changes",
                                  // check to make sure input is good
                                  function: () => vm.dispatchEditAdvertAction(
                                    advertId: vm.advert.id,
                                    title: titleController.value.text,
                                    description:
                                        descriptionController.value.text,
                                  ), //need to dispatch save job action?
                                ),
                          //********************************************//
                          const Padding(padding: EdgeInsets.all(5)),

                          //************DISCARD BUTTON*****************//
                          ButtonWidget(
                            text: "Discard",
                            color: "dark",
                            function: vm.popPage,
                          )
                          //********************************************//
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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
class _Factory extends VmFactory<AppState, EditAdvertPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.activeAd!,
        loading: state.wait.isWaiting,
        dispatchEditAdvertAction: ({
          required String advertId,
          String? title,
          String? location,
          String? description,
          String? type,
        }) =>
            dispatch(
          EditAdvertAction(
            advertId: advertId,
            description: description,
            type: type,
            location: location,
            title: title,
          ),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;
  final void Function({
    required String advertId,
    String? title,
    String? location,
    String? description,
    String? type,
  }) dispatchEditAdvertAction;
  final bool loading;

  _ViewModel({
    required this.loading,
    required this.popPage,
    required this.advert,
    required this.dispatchEditAdvertAction,
  }) : super(equals: [loading]); // implementinf hashcode
}
