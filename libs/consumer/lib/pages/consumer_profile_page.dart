import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';

class ConsumerProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(title: "PROFILE", store: store),
                //********************************************************//

                //*******************CONSUMER NAME************************//
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 50.0,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 10)),
                  Text(
                    (vm.userDetails.name != null)
                        ? vm.userDetails.name!
                        : "null",
                    style: const TextStyle(fontSize: 30),
                  ),
                ]),
                //********************************************************//

                const Padding(padding: EdgeInsets.all(20)),

                //*******************CONSUMER DETAILS************************//

                Stack(alignment: Alignment.center, children: <Widget>[
                  //overlay
                  BottomOverlayWidget(
                    height: MediaQuery.of(context).size.height / 1.5,
                  ),

                  //location
                  Positioned(
                    top: 40,
                    left: 45,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.location_on,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Text("Location",
                            style:
                                TextStyle(fontSize: 26, color: Colors.white70)),
                      ],
                    ),
                  ),

                  Positioned(
                      top: 80,
                      left: 52,
                      child: Text(
                          (vm.userDetails.location != null)
                              ? "${vm.userDetails.location!.address.city}, ${vm.userDetails.location!.address.province}"
                              : "null",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white))),

                  //cellphone
                  Positioned(
                    top: 140,
                    left: 45,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.phone,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Text("Cellphone",
                            style:
                                TextStyle(fontSize: 26, color: Colors.white70)),
                      ],
                    ),
                  ),

                  Positioned(
                      top: 180,
                      left: 52,
                      child: Text(
                          (vm.userDetails.cellNo != null)
                              ? vm.userDetails.cellNo!
                              : "null",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white))),

                  //email
                  Positioned(
                    top: 240,
                    left: 45,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.email,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Text("Email",
                            style:
                                TextStyle(fontSize: 26, color: Colors.white70)),
                      ],
                    ),
                  ),

                  Positioned(
                      top: 280,
                      left: 52,
                      child: Text(vm.userDetails.email,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white))),

                  Positioned(
                    top: 300,
                    right: 35,
                    child: IconButton(
                      onPressed: vm.pushEditProfilePage,
                      icon: const Icon(Icons.edit),
                      color: Colors.white70,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),

        //************************NAVBAR***********************/
        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
        //*************************************************//
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ConsumerProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/consumer/edit_profile_page'),
          ),
      userDetails: state.userDetails!);
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushEditProfilePage;
  final UserModel userDetails;

  _ViewModel({
    required this.pushEditProfilePage,
    required this.userDetails,
  }) : super(equals: [userDetails]);
}
