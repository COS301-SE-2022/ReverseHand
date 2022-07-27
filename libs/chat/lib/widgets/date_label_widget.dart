import 'package:flutter/material.dart';

class DateLabelWidget extends StatelessWidget {
  final String label;

  const DateLabelWidget({
    Key? key,
    required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Padding(
      padding:const EdgeInsets.symmetric(vertical: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12),
        ),   
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal:12),
          child: Text(
            label,
            style: const TextStyle(
              fontSize:12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

      ),
   );
  }}