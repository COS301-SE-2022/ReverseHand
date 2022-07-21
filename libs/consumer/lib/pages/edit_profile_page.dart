import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:geolocation/pages/location_search_page.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:uuid/uuid.dart';

class EditProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final locationController = TextEditingController();

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          resizeToAvoidBottomInset:
              false, //prevents floatingActionButton appearing above keyboard
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET******************//
                  const AppBarWidget(title: "Edit Profile"),
                  //***************************************************//

                  //**********************NAME************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      label: "name",
                      obscure: false,
                      min: 1,
                      controller: null,
                    ),
                  ),
                  //**************************************************//

                  //********************NUMBER**********************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "cellphone number",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  //********************NUMBER**********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "location",
                      obscure: false,
                      controller: locationController,
                      onTap: () async {
                        final sessionToken = const Uuid().v1();
                        final result = await showSearch(
                            context: context,
                            delegate:
                                LocationSearchPage(sessionToken, widget.store));
                        if (result != null) {
                          setState(() {
                            locationController.text = result.description;
                          });
                        }
                      },
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  // /*******************Location Button ****************/

                  // ProfileButtonWidget(
                  //   function: () {
                  //     final sessionToken = const Uuid().v1();
                  //     showSearch(
                  //         context: context,
                  //         delegate: LocationSearchPage(sessionToken, store));
                  //   },
                  //   height: 60,
                  //   icon: null,
                  //   text: 'Location',
                  //   width: 365,
                  // ),

                  // const Padding(padding: EdgeInsets.only(bottom: 30)),

                  // /**************************************************/

                  if (vm.isRegistered) ...[
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes", function: vm.pushProfilePage),
                    //**************************************************//

                    const Padding(padding: EdgeInsets.all(8)),
                    ButtonWidget(
                        text: "Discard",
                        color: "dark",
                        function: vm.pushProfilePage),
                  ] else
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes", function: vm.pushProfilePage),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _EditProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
    // dispatchCreateUserAction: () =>
    //       dispatch(CreateUserAction()),
        pushProfilePage: () => dispatch(
          NavigateAction.pushNamed('/consumer/consumer_profile_page'),
        ),
        pushLocationConfirmPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/location_confirm'),
        ),
        isRegistered: state.userDetails!.registered!,
      );
}

// view model
class _ViewModel extends Vm {
  // final void Function() dispatchCreateUserAction;
  final VoidCallback pushProfilePage;
  final VoidCallback pushLocationConfirmPage;
  final bool isRegistered;

  _ViewModel({
    // required this.dispatchCreateUserAction,
    required this.pushProfilePage,
    required this.pushLocationConfirmPage,
    required this.isRegistered,
  }); // implementinf hashcode
}

List<Widget> showButtons(bool isRegistered, Store<AppState> store) {
  if (isRegistered) {
    return [];
  } else {
    return [];
  }
}
