import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:general/methods/toast_error.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/textfield.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux_comp/actions/adverts/create_advert_action.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
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

  List<XFile>? _files;

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
              const Padding(padding: EdgeInsets.only(top: 20)),
              const HintWidget(
                  text: "Enter a title", colour: Colors.white70, padding: 15),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: TextFieldWidget(
                  label: "Title",
                  obscure: false,
                  min: 1,
                  controller: titleController,
                  initialVal: null,
                ),
              ),

              //trade type
              const HintWidget(
                  text: "Select the relevant trade type",
                  colour: Colors.white70,
                  padding: 15),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: InkWell(
                  onTap: () => showRadioSelect(),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          trade == null ? "Trade Type" : trade!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              //description
              const HintWidget(
                  text: "Enter a short description of the job",
                  colour: Colors.white70,
                  padding: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: TextFieldWidget(
                  label: "Description",
                  obscure: false,
                  min: 3,
                  controller: descrController,
                  initialVal: null,
                ),
              ),

              //location
              const HintWidget(
                text:
                    "The address for the job.\nOnly the city will be displayed",
                colour: Colors.white70,
                padding: 15,
              ),
              StoreConnector<AppState, _ViewModel>(
                vm: () => _Factory(this),
                builder: (BuildContext context, _ViewModel vm) => Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //GET THE WHOLE ADDRESS?
                                  Text(
                                    (vm.locationResult == null)
                                        ? vm.userLocation.address.city
                                        : vm.locationResult!.address.city,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  InkWell(
                                    onTap: vm.pushLocationPage,
                                    child: const Text(
                                      "change address",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white70,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ))),
                    )),
              ),
              //*************************************************//

              //add photos
              const HintWidget(
                text: "Select photos related to the job",
                colour: Colors.white70,
                padding: 15,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: InkWell(
                  onTap: () async {
                    ImagePicker picker = ImagePicker();

                    _files = await picker.pickMultiImage(imageQuality: 50);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Select Photos",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
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
                        ? const LoadingWidget(topPadding: 0, bottomPadding: 10)
                        : LongButtonWidget(
                            text: "Create Job",
                            function: () {
                              if (titleController.value.text != "" &&
                                  trade != null) {
                                vm.dispatchCreateAdvertActions(
                                  widget.store.state.userDetails.id,
                                  titleController.value.text,
                                  (vm.locationResult == null)
                                      ? Domain(
                                          city: vm.userLocation.address.city,
                                          province:
                                              vm.userLocation.address.province,
                                          coordinates:
                                              vm.userLocation.coordinates)
                                      : Domain(
                                          city: vm.locationResult!.address.city,
                                          province: vm
                                              .locationResult!.address.province,
                                          coordinates:
                                              vm.locationResult!.coordinates),
                                  trade!,
                                  descrController.value.text,
                                  _files?.map((e) => File(e.path)).toList(),
                                );
                              } else {
                                displayToastError(context,
                                    "Title and Trade Type must be included");
                              }
                            },
                          ),
                    //********************************************//

                    //************DISCARD BUTTON*****************//
                    TransparentLongButtonWidget(
                      text: "Discard",
                      function: vm.popPage,
                    ),
                    //********************************************//

                    const Padding(padding: EdgeInsets.only(top: 20))
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
        dispatchCreateAdvertActions: (
          String customerId,
          String title,
          Domain domain,
          String trade,
          String? description,
          List<File>? files,
        ) =>
            dispatch(
          CreateAdvertAction(
            customerId,
            title,
            domain,
            trade,
            description: description,
            files: files,
          ),
        ),
        loading: state.wait.isWaiting,
        locationResult: state.locationResult,
        userLocation: state.userDetails.location!,
        pushLocationPage: () => dispatch(NavigateAction.pushNamed(
            "/geolocation/custom_location_search",
            arguments: false)),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(
    String id,
    String title,
    Domain domanin,
    String trade,
    String? descr,
    List<File>? files,
  ) dispatchCreateAdvertActions;
  final VoidCallback pushLocationPage;
  final VoidCallback popPage;
  final bool loading;
  final Location userLocation;
  final Location? locationResult;

  _ViewModel({
    required this.loading,
    required this.dispatchCreateAdvertActions,
    required this.pushLocationPage,
    required this.userLocation,
    required this.locationResult,
    required this.popPage,
  }) : super(equals: [
          loading,
          userLocation,
          locationResult
        ]); // implementinf hashcode
}
