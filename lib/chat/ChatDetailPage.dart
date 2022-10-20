

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sellthedwell/utils/colors.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/circular_progress.dart';
import 'ChatMessage.dart';

class ChatDetailPage extends StatefulWidget{
  var to_Id;
  var name;
  var imageUrl;

  ChatDetailPage(String to_id, String name,String image_url){
    this.to_Id = to_id;
    this.imageUrl = image_url;
    this.name = name;
  }

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(to_Id);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController textinput = TextEditingController();
  String to_id = "";
  var name ="";
  var imageUrl = "";
  List chatList = [];
  bool loading = false;
  Map<String, dynamic> responsebody = Map();


  List<ChatMessage> messages = [
    ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
    ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
    ChatMessage(messageContent: "Hey Kriss, I am doing fine dude. wbu?", messageType: "sender"),
    ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
    ChatMessage(messageContent: "Is there any thing wrong?", messageType: "sender"),
  ];

  _ChatDetailPageState(String to_id){
    this.to_id = to_id;
  }
  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  void initState() {
    super.initState();
    print(to_id);
    Timer.periodic(Duration(seconds: 3), (Timer t) => getChatApi());
  }

  void getChatApi() async{

    try{
      print(to_id);
      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/get_chat_message"),
        body: {"to_id": to_id},
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        responsebody = jsonDecode(response.body.toString());
        var listData =  jsonDecode(response.body)["data"];
        chatList.clear();
        setState(() {
          loading = true;
          name = responsebody["send_user"];
          imageUrl = responsebody["user_img"];
          chatList.addAll(listData);
        });

      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  void getSendChatApi() async{
    FocusScope.of(context).requestFocus(new FocusNode());
    try{

      Response response = await post(
        Uri.parse(Konstants.baseUrl+"/add_chat_message"),
        body: {
          "to_id": to_id.toString(),
          "message" :textinput.text.toString()},
        headers: await getHeaders(),
      );
      if(response.statusCode == 200){
        var  data = jsonDecode(response.body.toString());
        setState(() {
          textinput.text = "";
         print("success");
        });

      }else{
        print("failed");
      }

    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  SizedBox(width: 2,),
                  imageUrl == ""
                  ? CircleAvatar(
                    backgroundColor: ColorUtils.blueColor,
                    maxRadius: 20,
                  ):
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    maxRadius: 20,
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        SizedBox(height: 6,),
                        /*Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),*/
                        ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          loading == false
              ? const Center(child: CircularProgressWidget())
              :
          SingleChildScrollView (
            reverse: true,
            child :    ListView.builder(
              itemCount: chatList.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 10,bottom: 70),
              reverse: false,
              itemBuilder: (context, index){
                return Container(
                  padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                  child: Align(
                    alignment: (chatList[index]["class"] == "text-right"
                        ?Alignment.topRight
                        :Alignment.topLeft),
                    child : Container(
                      decoration : BoxDecoration(
                        borderRadius : BorderRadius.circular(20),
                        color: (chatList[index]["class"] == "text-right"?Colors.red.shade400:Colors.grey.shade200),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chatList[index]["message"], style: TextStyle(fontSize: 15,color: Colors.black)),
                          Text(chatList[index]["updated_at"], style: TextStyle(fontSize: 12,color: Colors.black))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                /*  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                     *//* child: Icon(Icons.add, color: Colors.white, size: 20, ),*//*
                    ),
                  ),*/
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: textinput,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      if(textinput.text.toString() == "" || textinput.text.toString() == null){

                      }else {
                        getSendChatApi();
                      }
                    },
                    child: Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: ColorUtils.primary,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}