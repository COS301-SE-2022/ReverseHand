import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ChatAppBarWidget extends StatelessWidget {
  final String title;
  const ChatAppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ClipPath is alternative - keep this comment for now to remember
    return PhysicalShape(
        clipper: AppBarClipper(),
        elevation: 3.0,
        color: Theme.of(context).primaryColorDark,
        child: Container(
          height: 155, //still deciding on a good height
          alignment: const Alignment(
              0, -.5), //might swap this out for an Align widget around text
          child: Row(
            children: [
              StoreConnector<AppState, _ViewModel>(
                vm: () => _Factory(this),
                builder: (BuildContext context, _ViewModel vm) => IconButton(
                    onPressed: vm.popPage,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 180)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),
            ],
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
class _Factory extends VmFactory<AppState, ChatAppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;

  _ViewModel({
    required this.popPage,
  }); // implementinf hashcode

}
