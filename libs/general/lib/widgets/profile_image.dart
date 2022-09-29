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
            return Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: vm.profilePhoto == null
                      ? const AssetImage("../../assets/images/profile.png",
                          package: 'general')
                      : Image.network(vm.profilePhoto!).image,
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: InkWell(
                    // onTap: () =>
                    //     bottomSheet(context, vm.dispatchAddtoBucketAction),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      backgroundColor: Theme.of(context).primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      builder: (BuildContext context) {
                        return bottomSheet(
                          context,
                          vm.dispatchAddtoBucketAction,
                        );
                      },
                    ),
                    child: Stack(
                      children: const <Widget>[
                        Positioned(
                          left: 1.0,
                          top: 2.0,
                          child: Icon(Icons.camera_alt, color: Colors.black54),
                        ),
                        Icon(Icons.camera_alt, color: Colors.white),
                      ],
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
      color: Theme.of(context).primaryColorDark,
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
              icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
              onPressed: () async {
                Navigator.pop(context);
                XFile? file = (await takePhoto(
                  ImageSource.camera,
                ));
                if (file != null) func(File(file.path));
              },
              label: const Text("Camera",
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextButton.icon(
                icon: const Icon(Icons.image, color: Colors.white, size: 30),
                onPressed: () async {
                  Navigator.pop(context);
                  XFile? file = (await takePhoto(ImageSource.gallery));
                  if (file != null) func(File(file.path));
                },
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Future<XFile?> takePhoto(ImageSource source) async {
    ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front,
    );

    return file;
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ProfileImageWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        profilePhoto: state.userDetails.profileImage,
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
  final String? profilePhoto;
  final void Function(File file) dispatchAddtoBucketAction;

  _ViewModel({
    required this.profilePhoto,
    required this.dispatchAddtoBucketAction,
  }) : super(equals: [profilePhoto]); // implementinf hashcode
}
