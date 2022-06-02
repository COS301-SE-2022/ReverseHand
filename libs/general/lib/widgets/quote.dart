import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //     padding: const EdgeInsets.only(top: 20.0, left: 60.0, bottom: 10),
    //     child: Container(
    //       padding: const EdgeInsets.all(8),
    //       alignment: Alignment.bottomCenter,
    //       decoration: const BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.all(Radius.circular(20.0))),
    //       child: Padding(
    //         padding: const EdgeInsets.all(3.0),
    //         child: Row(children: const <Widget>[
    //           Icon(
    //             Icons.file_copy_rounded,
    //             color: Colors.black,
    //             size: 25.0,
    //             semanticLabel: 'Text to announce in accessibility modes',
    //           ),
    //           Padding(padding: EdgeInsets.all(2)),
    //           Text(
    //             "Download Quote",
    //             style: TextStyle(fontSize: 25, color: Colors.black),
    //             textAlign: TextAlign.center,
    //           ),
    //         ]),
    //       ),
    //     ));
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.white,
        shadowColor: Colors.black,
        elevation: 9,
        textStyle: const TextStyle(fontSize: 20),
        minimumSize: const Size(200, 50),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
      ),
      onPressed: () {},
      child: Text("Download Quote"),
    );
  }
}
