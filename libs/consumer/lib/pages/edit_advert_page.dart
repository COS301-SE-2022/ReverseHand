import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:general/widgets/open_image_widget.dart';
import 'package:general/widgets/textfield.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/actions/adverts/edit_advert_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/radio_select_widget.dart';

class EditAdvertPage extends StatefulWidget {
  final Store<AppState> store;

  const EditAdvertPage({Key? key, required this.store}) : super(key: key);

  @override
  State<EditAdvertPage> createState() => _EditAdvertPageState();
}

class _EditAdvertPageState extends State<EditAdvertPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();

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
    descrController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   titleController.addListener(() {
  //     setState(() {
  //       titleController = titleController;
  //     });
  //   });
  //   descrController.addListener(() {
  //     setState(() {
  //       descrController = descrController;
  //     });
  //   });

  //   super.initState();
  // }

  //*****Calls method to create a new job*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
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
                  AppBarWidget(title: "EDIT JOB", store: widget.store),
                  //********************************************************//

                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: HintWidget(
                        text: "Edit necessary fields then save the changes",
                        colour: Colors.white70,
                        padding: 15),
                  ),

                  //**************** TITLE ********************** */
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: TextFieldWidget(
                        label: "Title",
                        obscure: false,
                        min: 1,
                        controller: titleController,
                        initialVal: titleController.text.isEmpty
                            ? vm.advert.title
                            : titleController.text),
                  ),
                  //************************************************//

                  //**************** TRADE TYPE******************** */
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                      child: InkWell(
                        onTap: () => showRadioSelect(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    trade == null ? "Trade Type" : trade!,
                                    style: const TextStyle(fontSize: 18),
                                  ))),
                        ),
                      )),
                  //************************************************//

                  //**************** DESCRIPTION****************** */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: TextFieldWidget(
                      initialVal: descrController.text.isEmpty
                          ? vm.advert.description
                          : descrController.text,
                      label: "Description",
                      obscure: false,
                      min: 3,
                      controller: descrController,
                    ),
                  ),
                  //*************************************************//

                  //**************** LOCATION ****************** */
                  StoreConnector<AppState, _ViewModel>(
                    vm: () => _Factory(this),
                    builder: (BuildContext context, _ViewModel vm) => Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.store.state.userDetails.location!
                                            .address.city,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      InkWell(
                                        onTap:
                                            () {}, //should be able to change the location of the job on tap
                                        child: const Text(
                                          "change address",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white70,
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                      ),
                                    ],
                                  ))),
                        )),
                  ),
                  //*************************************************//

                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 30, right: 20),
                        child: Text(
                          "Select Images: ",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      OpenImageWidget(store: widget.store),
                    ],
                  ),

                  StoreConnector<AppState, _ViewModel>(
                    vm: () => _Factory(this),
                    builder: (BuildContext context, _ViewModel vm) => Column(
                      children: [
                        const Padding(
                            padding:
                                EdgeInsets.only(right: 50, left: 50, top: 35)),

                        //*********SAVE BUTTON******************//
                        vm.loading
                            ? const LoadingWidget(
                                topPadding: 0, bottomPadding: 0)
                            : LongButtonWidget(
                                text: "Save Changes",
                                // check to make sure input is good
                                function: () => vm.dispatchEditAdvertAction(
                                  advertId: vm.advert.id,
                                  title: titleController.value.text,
                                  description: descrController.value.text,
                                  domain: vm.advert.domain,
                                ), //need to dispatch save job action?
                              ),
                        //********************************************//
                        const Padding(padding: EdgeInsets.all(5)),

                        //************DISCARD BUTTON*****************//
                        TransparentLongButtonWidget(
                          text: "Discard",
                          function: vm.popPage,
                        )
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
          store: widget.store,
        ),
        //*****************************************************/
      ),
    );
  }
}

// // factory for view model
class _Factory extends VmFactory<AppState, _EditAdvertPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.activeAd!,
        loading: state.wait.isWaiting,
        dispatchEditAdvertAction: ({
          required String advertId,
          String? title,
          Domain? domain,
          String? description,
          String? type,
        }) =>
            dispatch(
          EditAdvertAction(
            advertId: advertId,
            description: description,
            type: type,
            domain: domain,
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
    Domain? domain,
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
