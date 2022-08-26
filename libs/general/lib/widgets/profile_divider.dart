import 'package:flutter/material.dart';

class ProfileDividerWidget extends StatelessWidget {
  const ProfileDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white,
      thickness: 0.5,
      indent: 30,
      endIndent: 30,
    );
  }
}
