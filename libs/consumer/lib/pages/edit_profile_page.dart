import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';

class EditProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const EditProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: const [
                  //*******************APP BAR WIDGET*********************//

                  AppBarWidget(title: "Edit Profile"),
                  //********************************************************//
                ],
              ),
            ),
          ),

          //*******************ADD BUTTON********************//
          floatingActionButton: FloatingActionButton(
            // onPressed: () => vm.pushCreateAdvertPage(), //how to get vm?
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //*************************************************//

          //************************NAVBAR***********************/
          bottomNavigationBar: const NavBarWidget(),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, EditProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/consumer/consumer_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushEditProfilePage;

  _ViewModel({
    required this.pushEditProfilePage,
  }); // implementinf hashcode
}
