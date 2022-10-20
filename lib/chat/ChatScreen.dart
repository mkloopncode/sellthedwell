

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../agora/pages/index.dart';
import '../services/network_service.dart';
import '../utils/strings.dart';
import '../widgets/circular_progress.dart';
import 'ChatUsers.dart';
import 'ConversationList.dart';

class ChatScreen extends StatefulWidget{
  @override
  ChatScreenState createState() => ChatScreenState();

}


class ChatScreenState extends State<ChatScreen>{

  List userList = [];
  bool loading = false;
  TextEditingController editingController = TextEditingController();





  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  void getUserList() async{
    /* showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );*/


    try{

      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/chat_conversations"),
        body: {},
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        var  data = jsonDecode(response.body.toString());
        var listData =  jsonDecode(response.body)["data"];
        userList = [];
          setState(() {
            loading = true;
            userList.addAll(listData);
          });

      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  void initState() {
    super.initState();

    getUserList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {});
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                      hintText : "Search...",
                      hintStyle : TextStyle(color: Colors.grey.shade600),
                      prefixIcon : Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.grey.shade100
                          )
                      ),
                    ),
                  ),
                  /*IconButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IndexPage()
                      ),
                    );
                  }, icon: Icon(Icons.camera_alt))*/
                ],
              ),
            ),
            loading == false
            ? const Center(child: CircularProgressWidget())
            : userList.length == 0
            ?  Container(
                margin: EdgeInsets.only(top: 180),
                child : Center(
                child : Text("Data not found",style: TextStyle(fontSize: 16,color:Colors.black))
            )):
            ListView.builder(
              itemCount: userList.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                if (editingController.text.isEmpty) {
                  return ConversationList(
                    name: userList[index]["name"],
                    messageText: userList[index]["message"],
                    imageUrl: userList[index]["profile_pic"],
                    time: userList[index]["created_at"],
                    isMessageRead: (index == 0 || index == 3)?true:false,
                    to_Id : userList[index]["to_id"].toString(),
                  );
                } else if (userList[index]["name"]
                    .toLowerCase()
                    .contains(editingController.text)) {
                  return ConversationList(
                    name: userList[index]["name"],
                    messageText: userList[index]["message"],
                    imageUrl: userList[index]["profile_pic"],
                    time: userList[index]["created_at"],
                    isMessageRead: (index == 0 || index == 3)?true:false,
                    to_Id : userList[index]["to_id"].toString(),
                  );
                } else {
                  return Container();
                }
              },
            ) ,
          ],
        ),
      ),
    );

  }

}
