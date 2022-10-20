
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sellthedwell/chat/ChatScreen.dart';
import 'package:sellthedwell/chat/GroupChatScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/konstants.dart';

class ChatTabScreen extends StatefulWidget{
  @override
  ChatTabScreenState createState() => ChatTabScreenState();

}

class ChatTabScreenState extends State<ChatTabScreen>{
   String packageName = '' ;
   String token = '' ;
  load_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    packageName = prefs.getString('package_name') ?? "";
     token = prefs.getString(Konstants.keyToken) ?? "";
    await getPackageDetails();
  }

    getHeaders() async {
     return <String, String>{
       "Authorizations": "Bearer $token",
     };
   }

    getPackageDetails() async{
print("Entry");
     try{
print(Konstants.baseUrl+"/user/user_package_detail");
print(getHeaders());
       Response response = await get(
         Uri.parse(Konstants.baseUrl+"/user/user_package_detail"),

         headers: await getHeaders(),
       );
       if(response.statusCode == 200){
         var  data = jsonDecode(response.body.toString());
         var listData =  jsonDecode(response.body)["data"];
         print("123nk");
         print(listData['packagedetails'][0]['name']);
         packageName = listData['packagedetails'][0]['name'];

       }else{
         print("failed");
       }

     }catch(e){
       print(e.toString());
     }
   }


  void initState() {
    super.initState();

    load_data();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFF3F3F3),
          appBar: AppBar(
            titleSpacing: 10,
            toolbarHeight: 50,
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Container(
              width: double.infinity,
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
              SafeArea(
              child: Text("Conversations",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable : true,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: "Users",),
                Tab(text : "GroupChat")
              ],
            ),
          ),
          body:
        TabBarView(
              children: [
                ChatScreen(),
                packageName == 'FREE' ?  SizedBox() : GroupChatScreen() ,
              ],
            ),
          ),
      ),
    );

  }

}