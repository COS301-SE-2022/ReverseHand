import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/adverts/edit_advert_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
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
                  AppBarWidget(title: "EDIT JOB", store: store),
                  //********************************************************//

                  //***TEXTFIELDWIDGETS TO GET DATA FROM CONSUMER**//
                  const Padding(padding: EdgeInsets.only(left: 10),
                  child: HintWidget(
                      text: "Edit necessary fields then save the changes", colour: Colors.white70, padding: 15),
                  ),

                  //title
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: TextFieldWidget(
                      label: "Title",
                      obscure: false,
                      min: 1,
                      controller: titleController,
                      initialVal: vm.advert.title,
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
                            ? const LoadingWidget(topPadding: 0, bottomPadding: 0)
                            : ButtonWidget(
                                text: "Save Changes",
                                // check to make sure input is good
                                function: () => vm.dispatchEditAdvertAction(
                                  advertId: vm.advert.id,
                                  title: titleController.value.text,
                                  description: descriptionController.value.text,
                                  domain: vm.advert.domain,
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

// import 'package:async_redux/async_redux.dart';
// import 'package:general/widgets/long_button_widget.dart';
// import 'package:consumer/widgets/job_creation_popup.dart';
// import 'package:consumer/widgets/light_dialog_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:general/widgets/appbar.dart';
// import 'package:general/widgets/loading_widget.dart';
// import 'package:consumer/widgets/consumer_navbar.dart';
// import 'package:general/widgets/long_button_transparent.dart';
// import 'package:general/widgets/open_image_widget.dart';
// import 'package:general/widgets/textfield.dart';
// import 'package:general/widgets/hint_widget.dart';
// import 'package:redux_comp/actions/adverts/create_advert_action.dart';
// import 'package:redux_comp/actions/analytics_events/record_create_advert_action.dart';
// import 'package:redux_comp/models/geolocation/domain_model.dart';
// import 'package:redux_comp/redux_comp.dart';

// import '../widgets/radio_select_widget.dart';

// class CreateNewAdvertPage extends StatefulWidget {
//   final Store<AppState> store;

//   const CreateNewAdvertPage({Key? key, required this.store}) : super(key: key);

//   @override
//   State<CreateNewAdvertPage> createState() => _CreateNewAdvertPageState();
// }

// class _CreateNewAdvertPageState extends State<CreateNewAdvertPage> {
//   final titleController = TextEditingController();
//   final descrController = TextEditingController();
//   final tradeController = TextEditingController();

//   String? trade;

//   void showRadioSelect() async {
//     final String? result = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return const RadioSelectWidget();
//       },
//     );

//     // Update UI
//     if (result != null) {
//       setState(() {
//         trade = result;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     tradeController.dispose();
//     descrController.dispose();
//     super.dispose();
//   }

//   double deviceHeight(BuildContext context) =>
//       MediaQuery.of(context).size.height;

//   //*****Calls method to create a new job*****//
//   @override
//   Widget build(BuildContext context) {
//     return StoreProvider<AppState>(
//       store: widget.store,
//       child: Scaffold(
//         backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
//         body: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               //*******************APP BAR WIDGET*********************//
//               AppBarWidget(title: "Create a Job", store: widget.store),
//               //********************************************************//

//               //title
//               const Padding(padding: EdgeInsets.only(top: 20)),
//               const HintWidget(
//                   text: "Enter a title", colour: Colors.white70, padding: 15),

//               Padding(
//                 padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
//                 child: TextFieldWidget(
//                   label: "Title",
//                   obscure: false,
//                   min: 1,
//                   controller: titleController,
//                   initialVal: null,
//                 ),
//               ),

//               //trade type
//               const HintWidget(
//                   text: "Select all relevant trade types",
//                   colour: Colors.white70,
//                   padding: 15),

//               Padding(
//                   padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
//                   child: InkWell(
//                     // tick boxes and not radio buttons?
//                     onTap: () => showRadioSelect(),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.grey, width: 1)),
//                           child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Text(
//                                 trade == null ? "Trade Type" : trade!,
//                                 style: const TextStyle(fontSize: 18),
//                               ))),
//                     ),
//                   )),

//               //description
//               const HintWidget(
//                   text: "Enter a short description of the job",
//                   colour: Colors.white70,
//                   padding: 15),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
//                 child: TextFieldWidget(
//                   label: "Description",
//                   obscure: false,
//                   min: 3,
//                   controller: descrController,
//                   initialVal: null,
//                 ),
//               ),

//               //location
//               const HintWidget(
//                   text:
//                       "The address for the job. Only the city will be displayed",
//                   colour: Colors.white70,
//                   padding: 15),
//               StoreConnector<AppState, _ViewModel>(
//                 vm: () => _Factory(this),
//                 builder: (BuildContext context, _ViewModel vm) => Padding(
//                     padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.grey, width: 1)),
//                           child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   //GET THE WHOLE ADDRESS?
//                                   Text(
//                                     widget.store.state.userDetails.location!
//                                         .address.city,
//                                     style: const TextStyle(fontSize: 18),
//                                   ),
//                                   InkWell(
//                                     onTap:
//                                         () {}, //should be able to change the location of the job on tap
//                                     child: const Text(
//                                       "change address",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.white70,
//                                           decoration: TextDecoration.underline),
//                                     ),
//                                   ),
//                                 ],
//                               ))),
//                     )),
//               ),
//               //*************************************************//

//               //add photos
//               const HintWidget(
//                   text:
//                       "Take or Choose photos related to the job",
//                   colour: Colors.white70,
//                   padding: 15),
//               const Padding(padding: EdgeInsets.only(top: 5)),
//               OpenImageWidget(store: widget.store),
//               //*************************************************//

//               StoreConnector<AppState, _ViewModel>(
//                 vm: () => _Factory(this),
//                 builder: (BuildContext context, _ViewModel vm) => Column(
//                   children: [
//                     const Padding(padding: EdgeInsets.fromLTRB(10, 20, 20, 10)),

//                     //*********CREATE JOB BUTTON******************//
//                     vm.loading
//                         ? const LoadingWidget(topPadding: 0, bottomPadding: 0)
//                         : LongButtonWidget(
//                             text: "Create Job",
//                             function: () {
//                               if (titleController.value.text != "" &&
//                                   trade != null) {
//                                 vm.dispatchCreateAdvertActions(
//                                   widget.store.state.userDetails.id,
//                                   titleController.value.text,
//                                   Domain(
//                                       city: widget.store.state.userDetails
//                                           .location!.address.city,
//                                       province: widget.store.state.userDetails
//                                           .location!.address.province,
//                                       coordinates: widget.store.state
//                                           .userDetails.location!.coordinates),
//                                   trade!,
//                                   descrController.value.text,
//                                 );
//                                 vm.dispatchRecordCreateAdvertAction(
//                                     widget.store.state.userDetails.location!
//                                         .address.city,
//                                     widget.store.state.userDetails.location!
//                                         .address.province);
//                               } else {
//                                 (LightDialogHelper.display(context,
//                                     const CreationPopupWidget(), 210.0));
//                               }
//                             },
//                           ),
//                     //********************************************//

//                     //************DISCARD BUTTON*****************//
//                     TransparentLongButtonWidget(
//                       text: "Discard",
//                       function: vm.popPage,
//                     ),
//                     //********************************************//

//                     const Padding(padding: EdgeInsets.only(top: 20))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         //************************NAVBAR***********************/
//         bottomNavigationBar: NavBarWidget(
//           store: widget.store,
//         ),
//         //*****************************************************/
//       ),
//     );
//   }
// }

// // factory for view model
// class _Factory extends VmFactory<AppState, _CreateNewAdvertPageState> {
//   _Factory(widget) : super(widget);

//   @override
//   _ViewModel fromStore() => _ViewModel(
//         popPage: () => dispatch(NavigateAction.pop()),
//         dispatchCreateAdvertActions: (String customerId, String title,
//                 Domain domain, String trade, String? description) =>
//             dispatch(
//           CreateAdvertAction(
//             customerId,
//             title,
//             domain,
//             trade,
//             description: description,
//           ),
//         ),
//         dispatchRecordCreateAdvertAction: (String city, String province) =>
//             dispatch(RecordCreateAdvertAction(city: city, province: province)),
//         loading: state.wait.isWaiting,
//       );
// }

// // view model
// class _ViewModel extends Vm {
//   final void Function(
//           String id, String title, Domain domanin, String trade, String? descr)
//       dispatchCreateAdvertActions;
//   final void Function(String city, String province)
//       dispatchRecordCreateAdvertAction;
//   final VoidCallback popPage;
//   final bool loading;

//   _ViewModel({
//     required this.loading,
//     required this.dispatchCreateAdvertActions,
//     required this.dispatchRecordCreateAdvertAction,
//     required this.popPage,
//   }) : super(equals: [loading]); // implementinf hashcode
// }

