import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/floating_button.dart';

import '../widgets/navbar.dart';

class EditBidPage extends StatelessWidget {
  final Store<AppState> store;

  EditBidPage({Key? key, required this.store}) : super(key: key);

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
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: <Widget>[
                  //*******************APP BAR WIDGET*********************//
                  const AppBarWidget(title: "Edit Job"),
                  //********************************************************//

                  //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                    child: TextFieldWidget(
                      label: "Title",
                      obscure: false,
                      min: 2,
                      controller: titleController,
                      initialVal: vm.advert.title,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: TextFieldWidget(
                      label: "Description",
                      obscure: false,
                      min: 3,
                      controller: descrController,
                      initialVal: '${vm.advert.description}',
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
                          text: "Save Changes",
                          function: () {}, //need to dispatch save job action?
                        ),
                        //********************************************//
                        const Padding(padding: EdgeInsets.all(5)),

                        //************DISCARD BUTTON*****************//
                        ButtonWidget(
                            text: "Discard",
                            color: "dark",
                            function: vm.popPage)
                        //********************************************//
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, EditBidPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      popPage: () => dispatch(NavigateAction.pop()),
      advert: state.activeAd!);
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;

  _ViewModel(
      {required this.popPage, required this.advert}); // implementinf hashcode
}
