import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

//used in consumer and tradesman

class AppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const AppBarWidget({Key? key, required this.title, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ClipPath is alternative - keep this comment for now to remember
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => PhysicalShape(
            clipper: AppBarClipper(),
            elevation: 3.0,
            color: Theme.of(context).primaryColorDark,
            child: Container(
              height: 155,
              alignment: const Alignment(0, -.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      vm.pushActivityStreamPage();
                    },
                    splashRadius: 1,
                    // highlightColor: Colors.orange,
                    // splashColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double curveHeight = size.height / 2;
    var p = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(0, curveHeight, curveHeight, curveHeight)
      ..lineTo(size.width - curveHeight, curveHeight)
      ..quadraticBezierTo(size.width, curveHeight, size.width, size.height)
      ..lineTo(size.width, 0);

    return p;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// factory for view model
class _Factory extends VmFactory<AppState, AppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushActivityStreamPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/activity_stream'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushActivityStreamPage;

  _ViewModel({required this.pushActivityStreamPage});
}
