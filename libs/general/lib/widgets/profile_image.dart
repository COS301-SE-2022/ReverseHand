import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux_comp/actions/add_to_bucket_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bucket_model.dart';

class ProfileImageWidget extends StatelessWidget {
  final Store<AppState> store;

  const ProfileImageWidget({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Center(
        child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            ImagePicker picker = ImagePicker();

            return Stack(
              children: [
                CircleAvatar(
                  radius: 80.0,
                  // backgroundImage: _imageFile == null
                  //     // ? Image.asset('assets/images/profile.png',height: 250, width: 250,package: 'general',) as ImageProvider
                  //     ? const AssetImage("assets/images/profile.png",
                  //         package: 'general') as ImageProvider
                  //     : FileImage(File(_imageFile!.path)),
                  backgroundImage: vm.profilePhoto == null
                      ? const AssetImage("assets/images/profile.png",
                          package: 'general') as ImageProvider
                      : FileImage(vm.profilePhoto!),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: InkWell(
                    onTap: () async {
                      try {
                        XFile? file = await picker.pickImage(
                          source: ImageSource.camera,
                          preferredCameraDevice: CameraDevice.front,
                        );

                        print('yay');
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 28.0,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context, dynamic func) {
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
              onPressed: () async {
                XFile? file = (await takePhoto(ImageSource.camera));
                if (file != null) func(File(file.path));
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image, color: Colors.black),
              onPressed: () async {
                XFile? file = (await takePhoto(ImageSource.gallery));
                if (file != null) func(File(file.path));
              },
              label: const Text(
                "Gallery",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Future<XFile?> takePhoto(ImageSource source) async {
    // XFile? file = await picker.pickImage(
    //   source: source,
    // );

    // return file;
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ProfileImageWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        profilePhoto: state.userProfileImage,
        dispatchAddtoBucketAction: (File file) => dispatch(
          AddToBucketAction(
            fileType: FileType.profile,
            file: file,
          ),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final File? profilePhoto;
  final void Function(File file) dispatchAddtoBucketAction;

  _ViewModel({
    required this.profilePhoto,
    required this.dispatchAddtoBucketAction,
  }) : super(equals: [profilePhoto]); // implementinf hashcode
}
