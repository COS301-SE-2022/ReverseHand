import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/adverts/create_advert_action.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';

import '../widgets/radio_select_widget.dart';

class CreateNewAdvertPage extends StatefulWidget {
  final Store<AppState> store;

  const CreateNewAdvertPage({Key? key, required this.store}) : super(key: key);

  @override
  State<CreateNewAdvertPage> createState() => _CreateNewAdvertPageState();
}

class _CreateNewAdvertPageState extends State<CreateNewAdvertPage> {
  final titleController = TextEditingController();
  final descrController = TextEditingController();
  final tradeController = TextEditingController();

  String? trade;

  void showRadioSelect() async {
    final String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const RadioSelectWidget();
      },
    );

    // Update UI
    if (result != null) {
      setState(() {
        trade = result;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    tradeController.dispose();
    descrController.dispose();
    super.dispose();
  }

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  //*****Calls method to create a new job*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //*******************APP BAR WIDGET*********************//
              AppBarWidget(title: "Create a Job", store: widget.store),
              //********************************************************//

              //title
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 50, 15, 5),
                child: TextFieldWidget(
                  label: "Title",
                  obscure: false,
                  min: 1,
                  controller: titleController,
                  initialVal: null,
                ),
              ),

              //**************************DIVIDER**********************//
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              //******************************************************//

              //trade type
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: InkWell(
                    onTap: () => showRadioSelect(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                trade == null ? "Trade Type" : trade!,
                                style: const TextStyle(fontSize: 18),
                              ))),
                    ),
                  )),
              //**************************DIVIDER**********************//
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              //******************************************************//

              //description
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                    const Padding(padding: EdgeInsets.fromLTRB(10, 20, 20, 10)),

                    //*********CREATE JOB BUTTON******************//
                    vm.loading
                        ? const LoadingWidget(padding: 0)
                        : ButtonWidget(
                            text: "Create Job",
                            function: () {
                              if (titleController.value.text != "" &&
                                  trade != null) {
                                vm.dispatchCreateAdvertActions(
                                  widget.store.state.userDetails!.id,
                                  titleController.value.text,
                                  Domain(
                                      city: widget.store.state.userDetails!
                                          .location!.address.city,
                                      coordinates: widget.store.state
                                          .userDetails!.location!.coordinates),
                                  trade!,
                                  descrController.value.text,
                                );
                              }
                            },
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
          ),
        ),
        //************************NAVBAR***********************/
        bottomNavigationBar: NavBarWidget(
          store: widget.store,
        ),
        //*****************************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _CreateNewAdvertPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
        dispatchCreateAdvertActions: (String customerId, String title,
                Domain domain, String trade, String? description) =>
            dispatch(
          CreateAdvertAction(
            customerId,
            title,
            domain,
            trade,
            description: description,
          ),
        ),
        loading: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(
          String id, String title, Domain domanin, String trade, String? descr)
      dispatchCreateAdvertActions;
  final VoidCallback popPage;
  final bool loading;

  _ViewModel({
    required this.loading,
    required this.dispatchCreateAdvertActions,
    required this.popPage,
  }) : super(equals: [loading]); // implementinf hashcode
}
