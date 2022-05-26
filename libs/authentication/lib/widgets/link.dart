import 'package:flutter/material.dart';
// import '../methods/populate_login.dart';

class LinkWidget extends StatelessWidget {
  final String text1; 
  final String text2; 
  final String link;
  const LinkWidget({Key? key, required this.text1, required this.text2, required this.link}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            text1,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xfff5fffa),
            ),
            softWrap: false,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //     MaterialPageRoute(builder: (context) => const Login(store: widget.store,),
              //   ),
              // );
            },
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
              softWrap: false,
            ),
          ),
      ],
    );
  }
}
