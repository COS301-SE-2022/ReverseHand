import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/actions/logout_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/methods/populate_adverts.dart';
import 'package:redux_comp/redux_comp.dart';

class TradesmanJobListings extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
          body: SingleChildScrollView(
              child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                ...populateAdverts(vm.adverts, store),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        onPrimary: Colors.white,
                        shadowColor: Colors.black,
                        elevation: 9,
                        textStyle: const TextStyle(fontSize: 30),
                        minimumSize: const Size(400, 50),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      onPressed: () => vm.dispatchLogoutAction(),
                      child: const Text('Log Out'),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobListings> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.user!.adverts,
        dispatchLogoutAction: () => dispatch(LogoutAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final void Function() dispatchLogoutAction;
  _ViewModel({
    required this.adverts,
    required this.dispatchLogoutAction,
  });
}
