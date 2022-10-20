// controller for changing images and for state managment

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellthedwell/screens/details_screen.dart';
import 'package:sellthedwell/vr/initial_page.dart';

import '../models/property_model.dart';

class Controller extends GetxController {
  String? imageFileLeft = InitilPageState.image_vr![0] ;
  String? imageFileCenter = InitilPageState.image_vr![0];
  String? imageFileRight = InitilPageState.image_vr![0];
  String? imageFileFourth =  InitilPageState.image_vr![0];






  bool shouldRunFunction = true;
  List<String> image_vr = [];

  bool vrMode = true;
  bool leftButtonShow = true;
  bool rightButtonShow = true;
  String? currentImage  =InitilPageState.image_vr![0];

  // for vr arrow
  bool shouldShowLeftArrow = false;
  bool shouldShowRightArrow = false;


  // pick images

  pickCenterImage() async {
    imageFileCenter = InitilPageState.image_vr![1];
    currentImage = imageFileCenter ;
    update();
  /*  final ImagePicker _picker = ImagePicker();

    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {

    }*/
  }

  pickLeftImage() async {
    imageFileLeft = InitilPageState.image_vr![2];
    update();

   /* final ImagePicker _picker = ImagePicker();

    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFileLeft = image_vr![1];
      update();
    }*/
  }

  pickRightImage() async {
    imageFileRight = InitilPageState.image_vr![3];
    update();

    /*final ImagePicker _picker = ImagePicker();

    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFileRight = image_vr![2];
      update();
    }*/
  }

  pickRightfourth() async {
    imageFileFourth = InitilPageState.image_vr![0];
    update();

    /*final ImagePicker _picker = ImagePicker();

    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFileRight = image_vr![2];
      update();
    }*/
  }

  // logic for button clicks
  leftButtonLogic() {

    if (currentImage == imageFileCenter) {
      print('Showing center image');

      currentImage = imageFileLeft;
      leftButtonShow = false;
      update();
    }else if (currentImage == imageFileRight) {
      print('Showing center image');

      currentImage = imageFileCenter;
      leftButtonShow = true;
      rightButtonShow = true;
      update();
    }else if (currentImage == imageFileFourth) {
      print('Showing center image');

      currentImage = imageFileRight;
      leftButtonShow = true;
      rightButtonShow = true;
      update();
    }
    else {
      currentImage = imageFileCenter;
      leftButtonShow = true;
      rightButtonShow = true;
      update();
    }
  }

  rightButtonLogic() {
    if(currentImage == imageFileRight){
      currentImage = imageFileFourth;
      rightButtonShow = false;
      update();
    }else if(currentImage == imageFileCenter){
      currentImage = imageFileRight;
      rightButtonShow = true;
      leftButtonShow = true;
      update();
    }
  else {
      currentImage = imageFileCenter;
      rightButtonShow = true;
      leftButtonShow = true;
      update();
    }
  }

  bool showCenterImage = true;
  rightArrowLogic() async {
    print('inside right arrow login');

    if (currentImage == imageFileFourth) {
      print('showing right image returning');
      return;
    }

    if (currentImage == imageFileRight) {
      print('showing right image returning');
      currentImage = imageFileFourth;
      update();
    }
    if (currentImage == imageFileCenter) {
      print('current iamge is center image changing to right side image');
      currentImage = imageFileRight;
      update();
    }
    if (currentImage == imageFileLeft) {
      print('Current image is left image changeing to center image');
      currentImage = imageFileCenter;
      update();
    }
  }

  shouldRun() async {
    shouldRunFunction = false;
    await Future.delayed(Duration(seconds: 3));
    shouldRunFunction = true;

    update();
  }

  leftArrowLogic() async {
    // if (shouldChangeLeftImage) {
    //   leftButtonLogic();
    //   shouldChangeLeftImage = false;
    //   shouldChangeRightImage = true;
    // }
    print('inside left logic');

    if (currentImage == imageFileLeft) {
      return;
    }
    if (currentImage == imageFileCenter) {
      currentImage = imageFileLeft;
      update();
    }
    if (currentImage == imageFileRight) {
      currentImage = imageFileCenter;
      update();
    }
    if (currentImage == imageFileFourth) {
      currentImage = imageFileRight;
      update();
    }

  }

  changeVrModeValue() {
    if (vrMode == true) {
      vrMode = true;
      update();
    } else {
      vrMode = true;
      update();
    }
  }

  Future<bool> makeValuesDefault() {
    vrMode = true;
    leftButtonShow = true;
    rightButtonShow = true;
    currentImage = imageFileCenter;
    return Future.value(true);
  }

  @override
  void onInit() {
    for(int i = 0; i< InitilPageState.image_vr.length ; i++){
      if(i == 0){
        imageFileFourth =  InitilPageState.image_vr![0];
      }
      if(i== 1){
        imageFileCenter = InitilPageState.image_vr![1];
      }
      if(i == 2){
        imageFileLeft = InitilPageState.image_vr![2] ;
      }
      if(i ==3){
        imageFileRight = InitilPageState.image_vr![3];
      }

    }
    super.onInit();
  }
}
