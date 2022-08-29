import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  ProfileImageWidgetState createState() => ProfileImageWidgetState();
}

class ProfileImageWidgetState extends State<ProfileImageWidget> {
  bool circular = false;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              // ? Image.asset('assets/images/profile.png',height: 250, width: 250,package: 'general',) as ImageProvider
              ? const AssetImage("assets/images/profile.png", package: 'general') as ImageProvider
              : FileImage(File(_imageFile!.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera_alt, color: Colors.black),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image, color: Colors.black),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery", style: TextStyle(color: Colors.black),),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      // final File? imagefile = File(pickedFile!.path);
    });
  }
}