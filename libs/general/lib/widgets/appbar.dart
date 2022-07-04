import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ClipPath is alternative - keep this comment for now to remember
    return PhysicalShape(
        clipper: AppBarClipper(),
        elevation: 3.0,
        color: Theme.of(context).primaryColorDark,
        child: Container(
          height: 135, //still deciding on a good height
          alignment: const Alignment(
              0, -.5), //might swap this out for an Align widget around text
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
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
