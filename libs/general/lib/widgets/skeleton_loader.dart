import 'package:flutter/material.dart';

class SkeletonLoaderWidget extends StatelessWidget {
  const SkeletonLoaderWidget({Key? key}) : super(key: key);

  //not fully implemented yet

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: AnimatedContainer(
          height: 105,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Theme.of(context).primaryColorLight,
              ],
            ),
          ),
          duration: const Duration(seconds: 5),
          curve: Curves.easeInBack),
    );
  }
}
