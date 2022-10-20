import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/property_model.dart';
import 'controller.dart';
import 'image_show.dart';

class UploadThreeImagesFinal extends StatelessWidget {
  PropertyModel prop = PropertyModel();
  List<String> image_vr = [];

  UploadThreeImagesFinal(PropertyModel prop){
    this.prop = prop;
    this.image_vr = prop.images_vr!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // onWillPop: controller.makeValuesDefault,
      onWillPop: () {
        Get.delete<Controller>();
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Images',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
             /* Container(
                color: Colors.black12,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await controller.pickCenterImage();
                          },
                          child: Text('Center Image'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    await controller.pickRightImage();
                  },
                  child: Text('Right Image'),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () async {
                      controller.pickLeftImage();
                    },
                    child: Text('Left Image')),
              ),*/


              Expanded(
                  child:  Container(
                    padding : EdgeInsets.only(top: 50),
                    child : Center(
                        child : GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 2.0,
                            children: List.generate(image_vr.length, (index) {
                              return Container(
                                child: Image.network(image_vr[index],height: 300),
                              );
                            }
                            )
                        )
                    )
                  ),
              ),



              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text('watch images'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ImageShow(image_vr);
                    }));
                   /* if (controller.imageFileCenter != null &&
                        controller.imageFileLeft != null &&
                        controller.imageFileRight != null) {
                     *//* Get.to(ImageShow());*//*

                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ImageShow();
                      }));

                    } else {
                      return;
                    }*/
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
