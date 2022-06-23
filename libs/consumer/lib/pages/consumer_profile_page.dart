import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';

class ConsumerProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerProfilePage({Key? key, required this.store}) : super(key: key);

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
                children: [
                  //*******************APP BAR WIDGET*********************//

                  const AppBarWidget(title: "Profile"),
                  //********************************************************//

                  //*******************CONSUMER NAME************************//

                  const Text(
                    "Luke Skywalker",
                    style: TextStyle(fontSize: 30),
                  ),
                  //********************************************************//

                  //*********PADDING BETWEEN NAME AND OTHER DETAILS********//

                  const Padding(padding: EdgeInsets.all(50)),
                  //**************************************************//

                  //*******************CONSUMER DETAILS************************//
                  //location
                  const Text("Location",
                      style: TextStyle(fontSize: 20, color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 29.0,
                      ),
                      Text("Pretoria, Gauteng",
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  //email
                  const Text("Email",
                      style: TextStyle(fontSize: 20, color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 29.0,
                      ),
                      Text("info@gmail.com",
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  //cellphone
                  const Text("Cellphone",
                      style: TextStyle(fontSize: 20, color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 29.0,
                      ),
                      Text("012 345 6789",
                          style: TextStyle(fontSize: 20, color: Colors.white))
                    ],
                  ),

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
class _Factory extends VmFactory<AppState, ConsumerProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.user!.adverts,
        pushCreateAdvertPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/create_advert'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateAdvertPage;
  final List<AdvertModel> adverts;

  _ViewModel({
    required this.adverts,
    required this.pushCreateAdvertPage,
  }); // implementinf hashcode
}
