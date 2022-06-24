import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';

//stateless?

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  @override
  Widget build(BuildContext context) {
    //general shape and shadows
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),

      //extra clipping off edges
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),

        //bottom nav functionality
        child: BottomAppBar(
            color: Theme.of(context).primaryColorDark,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                //icon 1 - Profile
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),

                //icon 2 - Consumer Listings
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),

                //icon 3
                IconButton(
                  icon: const Icon(
                    Icons.print,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),

                //icon 4
                IconButton(
                  icon: const Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  splashRadius: 30,
                  highlightColor: Colors.orange,
                  splashColor: Colors.white,
                ),
              ],
            )),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, NavBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushProfilePage: () => dispatch(
          NavigateAction.pushNamed('/consumer/consumer_profile_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/consumer'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushConsumerListings;

  _ViewModel(
      {required this.pushProfilePage, required this.pushConsumerListings});
}
