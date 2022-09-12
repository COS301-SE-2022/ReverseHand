import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/add_to_bucket_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bucket_model.dart';

// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class ImageCarouselWidget extends StatelessWidget {
  List images;
  final Store<AppState> store;

  ImageCarouselWidget({Key? key, required this.images, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(height: 230),
      itemCount: images.length,
      itemBuilder: (context, index, realIndex) {
        final firstImage = images[index];

        return buildImage(firstImage, index, context);
      },
    );

  }

//the actual container for the carousel
 Widget buildImage(String firstImage, int index, BuildContext context) {
  return Container(
        margin: const EdgeInsets.only( left: 5, right: 5),
        color: Colors.grey,
        child: Image.network(
          firstImage,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        )
  );
  }
}

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, ImageCarouselWidget> {
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
