


import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/konstants.dart';
import '../utils/styles.dart';

class ImageAssests_HomePage extends StatefulWidget{
  String? modal_assets;
  ImageAssests_HomePage(String? modal_assets){
    this.modal_assets = modal_assets;
  }

  @override
  ImageAssestsState createState() => ImageAssestsState(modal_assets);

}


class ImageAssestsState extends State<ImageAssests_HomePage>{
  String? modal_assetsurl;

  ImageAssestsState(String? modal_assets){
    this.modal_assetsurl = modal_assets;
  }
  @override
  void initState() {

    // assigning name to the objects and providing the
    // object's file path (obj file)
    print(modal_assetsurl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          titleSpacing: -20,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios_new,color: ColorUtils.textColor),
              onPressed: () =>
                  Navigator.pop(context,true)
          ),
          title: Container(
              child: Text("3D Model",style: TextStyles.appBarTitle,)/* Image.asset(
                Konstants.logoPath,
                height: 32,
            ),*/
          ), // Set this height
        ),
        body: Container(
          color: Colors.white,
         child :  modal_assetsurl == null || modal_assetsurl == ""
          ?  Center(
             child : Text("Data not found",style: TextStyle(fontSize: 16,color:Colors.black))
         ):
         BabylonJSViewer(
            src: modal_assetsurl!,
          ),
        ),
      ),
    );
  }
  
}