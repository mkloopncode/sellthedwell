

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

import '../utils/colors.dart';
import '../utils/konstants.dart';
import '../utils/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PanoramicView extends StatefulWidget{
  String panorama_imageUrl = "";

  PanoramicView(String? panorama_imageUrl){
    this.panorama_imageUrl = panorama_imageUrl!;
  }

  @override
  PanoramicViewState createState() => PanoramicViewState(panorama_imageUrl);
}

class PanoramicViewState extends State<PanoramicView>{
  String panorama_imageUrl = "";

  PanoramicViewState(String panorama_imageUrl){
    this.panorama_imageUrl = panorama_imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    print(panorama_imageUrl);
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
        child:  Text("Photo View",style: TextStyles.appBarTitle,)/*Image.asset(
          Konstants.logoPath,
          height: 32,
        ),*/
      ), // Set this height
    ),

      body: Center(
        child: panorama_imageUrl == null || panorama_imageUrl == ""
          ? Center(
            child : Text("Data not found",style: TextStyle(fontSize: 16,color:Colors.black))
        ):
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: panorama_imageUrl,
        ),
        /*Panorama(
          child: Image.network(panorama_imageUrl),
        ),*/
      ),
    );
  }
  
}