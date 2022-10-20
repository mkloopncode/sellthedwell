import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../utils/colors.dart';
import 'controller.dart';

class ImageShow extends StatefulWidget {
  List<String> image_vr=[];
  ImageShow(List<String> image_vr){
    this.image_vr = image_vr;
  }

  @override
  State<ImageShow> createState() => _ImageShowState(image_vr);
}

class _ImageShowState extends State<ImageShow> {
  Controller controller = Get.put(Controller());
  List<String> image_vr=[];

  _ImageShowState(List<String> image_vr){
    this.image_vr = image_vr;
  }

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((event) {
      setState(() {
        startPosY = -(event.y);
      });

      controller.image_vr = image_vr;

      if (startPosY <= -1.4 && startPosY >= -1.7) {
        if (controller.shouldRunFunction &&
            controller.currentImage != controller.imageFileLeft) {
          controller.leftArrowLogic();
          controller.shouldRun();
        } else {
          print('not running function');
          return;
        }
      }
      if (startPosY >= 1.4 && startPosY <= 1.7) {
        if (controller.shouldRunFunction &&
            controller.currentImage != controller.imageFileRight) {
          controller.rightArrowLogic();
          controller.shouldRun();
        } else {
          print('not running function');
          return;
        }
      }
    });
  }

  double startPosX = 0;
  double startPosY = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.makeValuesDefault,
      child: GetBuilder<Controller>(builder: (controller) {
        return Scaffold(
          body: image_vr.length == 0
              ? Center(
              child : Text("Data not found",style: TextStyle(fontSize: 16,color:Colors.black))
          ):
          SafeArea(
            child:
                controller.vrMode ? vrView(controller) : normalView(controller),
          ),
        );
      }),
    );
  }

  vrView(Controller controller) {
    return Stack(
      children: [
        Column(
          children: [
            // first child
            SizedBox(height: 5,),
            Flexible(
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(controller.currentImage!),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 130,
                                width: 50,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // RotatedBox(
                                    //   quarterTurns: 1,
                                    //   child: Icon(
                                    //     Icons.arrow_back_ios_new,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    // Expanded(
                                    //   child: Container(
                                    //     // color: Colors.amber,
                                    //     alignment: Alignment(0, startPosY),
                                    //     child: Icon(
                                    //       Icons.add,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // ),
                                    // // RotatedBox(
                                    // //   quarterTurns: 1,
                                    // //   child: Icon(
                                    // //     Icons.arrow_forward_ios,
                                    // //     color: Colors.white,
                                    // //   ),
                                    // // ),
                                    // RotatedBox(
                                    //   quarterTurns: 1,
                                    //   child: Icon(
                                    //     Icons.arrow_forward_ios,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(.5),
                                      radius: 12,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.7),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.amber,
                                        alignment: Alignment(0, startPosY),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(.5),
                                      radius: 12,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.7),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (controller.rightButtonShow)
                        Align(
                          alignment: Alignment.centerRight,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                            Color.fromARGB(255, 255, 255, 255).withOpacity(.3),
                            child: IconButton(
                              icon: Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              onPressed: () {
                                controller.rightButtonLogic();
                              },
                            ),
                          ),
                        ),

                    ],
                  ),
                ),
              ),
            ),
            // second child
            SizedBox(height: 10,),
            Flexible(
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(controller.currentImage!),
                      ),
                      // if (controller.leftButtonShow)
                      //   Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: CircleAvatar(
                      //       radius: 20,
                      //       backgroundColor: Colors.pinkAccent.withOpacity(.3),
                      //       child: IconButton(
                      //         icon: Icon(
                      //           Icons.circle,
                      //           color: Color.fromARGB(255, 255, 64, 140),
                      //         ),
                      //         onPressed: () {
                      //           controller.leftButtonLogic();
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      Align(
                        alignment: Alignment.center,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 130,
                                width: 50,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // RotatedBox(
                                    //   quarterTurns: 1,
                                    //   child: Icon(
                                    //     Icons.arrow_back_ios_new,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),

                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(.5),
                                      radius: 12,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.7),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        // color: Colors.amber,
                                        alignment: Alignment(0, startPosY),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Colors.white.withOpacity(.5),
                                      radius: 12,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.7),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (controller.leftButtonShow)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor:
                            Color.fromARGB(255, 255, 254, 254).withOpacity(.3),
                            child: IconButton(
                              icon: Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              onPressed: () {
                                controller.leftButtonLogic();
                                setState((){

                                });
                              },
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: RotatedBox(
              quarterTurns: 3,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: ColorUtils.primary,
                  ),
                  onPressed: () {
                    controller.changeVrModeValue();
                    Navigator.pop(context);
                  },
                  child: Text('Exit VR'))),
        ),
      ],
    );
  }

  Container normalView(Controller controller) {
    return Container(
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   image: DecorationImage(image: FileImage(controller.currentImage)),
      // ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.network(controller.currentImage!),
          ),
          if (controller.leftButtonShow)
            Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    Color.fromARGB(255, 255, 254, 254).withOpacity(.3),
                child: IconButton(
                  icon: Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    controller.leftButtonLogic();
                    setState((){

                    });
                  },
                ),
              ),
            ),
          if (controller.rightButtonShow)
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: 20,
                backgroundColor:
                    Color.fromARGB(255, 255, 255, 255).withOpacity(.3),
                child: IconButton(
                  icon: Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  onPressed: () {
                    controller.rightButtonLogic();
                  },
                ),
              ),
            ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  //  backgroundColor: ColorUtils.primary,
                  ),
                  onPressed: () {
                    controller.changeVrModeValue();
                    setState((){

                    });
                  },
                  child: Text('VR Mode')))
        ],
      ),
    );
  }
}
