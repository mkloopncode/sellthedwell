import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/vr/image_show.dart';
import 'package:sellthedwell/vr/upload_images_final.dart';
import 'package:sellthedwell/vr/video_page.dart';

import '../utils/konstants.dart';
import '../utils/strings.dart';
import '../utils/styles.dart';
import '../widgets/custom_appbar.dart';
import 'controller.dart';

class InitialPage extends StatefulWidget {
  PropertyModel prop = PropertyModel();
  List<String> imageList = [];
  String vedioUrl = "";

  InitialPage(List<String> imageList, String video_vr) {
    this.imageList = imageList;
    this.vedioUrl = video_vr;
  }
  @override
  InitilPageState createState() => InitilPageState(imageList,vedioUrl);
}

class InitilPageState extends State<InitialPage>{
  List<String> imageList = [];
  static List<String>image_vr = [];
  static bool visibility = true;
  String vedioUrl = "";

  InitilPageState(List<String> imageList,String vedioUrl){
    this.vedioUrl = vedioUrl;
    this.imageList = imageList;
  }

  @override
  void initState() {
    image_vr = imageList;
    print("Done");
   print(InitilPageState.image_vr.length);
   /* controller.pickCenterImage();
    controller.pickLeftImage();
    controller.pickRightImage();
    controller.pickRightfourth();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text(Strings.virtualRealityTour,style: TextStyles.appBarTitle,)/* Image.asset(
                Konstants.logoPath,
                height: 32,
            ),*/
        ), // Set this height
      ),
      body: Container(
        color: Colors.white,
        child : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: visibility,
                  child:
                  ElevatedButton(
                    onPressed: () async {

                      if(vedioUrl.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (builder) {
                        return VideoPage(
                          vedioUrl,
                        );
                      }));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO Data Found")));
                      }

                      /*final ImagePicker _picker = ImagePicker();


              var pickedVideo =
                  await _picker.pickVideo(source: ImageSource.gallery);
              if (pickedVideo != null) {
                File videoFile = File(pickedVideo.path);

              }*/
                    },
                    child: Text('show video'),
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: ColorUtils.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width * .5, 50),
                    ),
                  ),),
                SizedBox(height: 24),
                // ElevatedButton(
                //   onPressed: () async {
                //     final ImagePicker _picker = ImagePicker();

                //     var pickedImage =
                //         await _picker.pickImage(source: ImageSource.gallery);
                //     if (pickedImage != null) {
                //       File imageFile = File(pickedImage.path);
                //       Navigator.push(context, MaterialPageRoute(builder: (builder) {
                //         return ImagePage(
                //           imageFile: imageFile,
                //         );
                //       }));
                //     }
                //   },
                //   child: Text('upload image'),
                //   style: ElevatedButton.styleFrom(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     minimumSize: Size(MediaQuery.of(context).size.width * .5, 50),
                //   ),
                // )
                ElevatedButton(
                  onPressed: () async {
                    // final ImagePicker _picker = ImagePicker();

                    // var pickedImage =
                    //     await _picker.pickImage(source: ImageSource.gallery);
                    // if (pickedImage != null) {
                    //   File imageFile = File(pickedImage.path);
                    //   Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    //     return ImagePage(
                    //       imageFile: imageFile,
                    //     );
                    //   }));
                    // }
                    // Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    //   return UploadThreeImages();
                    // }));
                    /* Get.to(UploadThreeImagesFinal());*/

                    if(image_vr.isNotEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ImageShow(image_vr);
                    }));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("NO Data Found")));
                    }

                  },
                  child: Text('show image'),
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: ColorUtils.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width * .5, 50),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
