import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;
  final VoidCallback? onPressed;

  const ActionButtonWidget({
    Key? key,
    required this.color,
    required this.icon,
    this.size = 45,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          splashColor: Theme.of(context).primaryColor,
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(
              icon,
              size: 26,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
