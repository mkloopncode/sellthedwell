

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../utils/colors.dart';
import '../utils/konstants.dart';
import '../utils/util_methods.dart';
import '../widgets/circular_progress.dart';
import '../widgets/custom_button_filled.dart';
import '../widgets/custom_textfield.dart';

class FlagScreen extends StatefulWidget{
  @override
  FlagClickState createState() => FlagClickState();
}

class FlagClickState extends State<FlagScreen>{
  final TextEditingController _flagContorller = TextEditingController();
  bool loading = true;

  void addFlag(BuildContext buildContext) async{

    CommonMethods.showLoading(buildContext);

    try{

      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/add_to_flga"),
        body: {
          "property_id" : "55",
          "message" : _flagContorller.text.toString(),
        },
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        toast("Succesfully done");
        CommonMethods.dismissLoading(buildContext);
        Navigator.pop(context,true);
      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            child:  Image.asset(
              Konstants.logoPath,
              height: 32,
            ),
          ), // Set this height
        ),
        body: Center(
          child : Container(
            margin: EdgeInsets.all(15),
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child :  CustomTextFieldWidget(
                    controller: _flagContorller,
                    labelText: "Please enter message",
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40,left: 20,right: 20),
                  child :  Row(
                    children: [
                      Expanded(
                        child: CustomFillButton(
                            onTapFunction: () {
                              if(_flagContorller.text.toString().trim().length == 0){
                                toast("Please enter message");
                              }else{
                                addFlag(context);
                              }
                            },
                            childText: "Submit"),
                      ),
                    ],
                  ),
                )
              ],
            )
          )
        ),
      ),
    );
  }

}