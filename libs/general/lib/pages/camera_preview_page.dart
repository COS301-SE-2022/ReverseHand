import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../widgets/button.dart';

//************************************ */
//  Photo preview page after taking on
//  live camera page
//************************************ */

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Preview Image'),
          backgroundColor: const Color.fromRGBO(243, 157, 55, 1),
        ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, children: [
            Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
            const SizedBox(height: 24),
            Text(picture.name),
            Positioned(
                top: 35,
                child: ButtonWidget(
                    text: "Choose Photo",
                    function: () {
                    
                    })),
          ]
        ),
      ),
    );
  }
}