import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/chatListModel.dart';
import 'package:network_2/Models/chatModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class Chat extends StatefulWidget {

  final String tagname1;
  final String tagname2;
  Chat({this.tagname1, this.tagname2});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  bool circularState = true;
  TextEditingController _post = new TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  List<ChatModel> data = [];
  ChatListModel chatListModel = ChatListModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      print(widget.tagname1);
      Map<String, String> body = {
        "tagname" : widget.tagname1
      };
      var response = await networkHandler.post("/profile/chats", body);
      if(response.statusCode == 200 || response.statusCode == 201){
        chatListModel = ChatListModel.fromJson(json.decode(response.body));
        setState(() {
          circularState = false;
          data = chatListModel.chats;
        });
      }else{
        Map<String, dynamic> output = json.decode(response.body);
        showAlertDialog(context, output["msg"]);
      }
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.blue[900],
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: boxDecoration(Colors.white, 40, Colors.black, 8, Colors.black),
            child: SingleChildScrollView(
              child: circularState ? Center(child: CircularProgressIndicator()) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    alignment: Alignment.topLeft,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Card(
                    elevation: 10,
                    color: Colors.blue[900],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text("Chats", style: TextStyle(fontSize: 20, color: Colors.white),)),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(tagname: widget.tagname1))
                        );
                      },
                        child: Text("View Profile", style: TextStyle(color: Colors.blue))
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          circularState = true;
                        });
                        fetchData();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        decoration: boxDecoration(Colors.white , 10, Colors.black, 2, Colors.black),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.refresh, size: 15, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  data.isNotEmpty ? Column(
                    children: data.map(
                            (link) =>
                                link.by == widget.tagname1 ? receivedMessage(link.subject, DateTime.parse(link.postedAt).toLocal()) : sendedMessage(link.subject, DateTime.parse(link.postedAt).toLocal())
                    )
                        .toList(),
                  ) : Container(),
                  inputField(context, BoxDecoration(), "Write here", "*", _post, 50, Icons.create),
                  SizedBox(height: 10,),
                  Center(child: send(context)),
                  SizedBox(height: 10),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.blue[900]),),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.blue[900]),),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.blue[900]),),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.blue[900]),),
                    ),
                  ),
                ],
              )
            )
          )
        ),
    );
  }

  Widget send(BuildContext context) {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black,width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () async {
          try{
            setState(() {
              circularState = true;
            });
            if(_post.text != ""){
              Map<String, String> body = {
                "tagname" : widget.tagname1,
                "subject" : _post.text
              };
              var response = await networkHandler.patch("/profile/postChat", body);
              if(response.statusCode == 200 || response.statusCode == 201){
                showAlertDialog(context, "posted");
                fetchData();
                setState(() {
                  _post.text = "";
                  circularState = false;
                });
              }else{
                showAlertDialog(context, "Error");
                setState(() {
                  circularState = false;
                });
              }
            }else{
              showAlertDialog(context, "Message can't be empty");
              setState(() {
                circularState = false;
              });
            }
          }catch(e){
            showAlertDialog(context, "Some error occurred");
            setState(() {
              circularState = false;
            });
          }
        },
        icon: circularState ? CircularProgressIndicator() : Icon(Icons.send, color: Colors.black, size: 35,),
      ),
    );
  }

  Widget sendedMessage(String label, DateTime dateTime) {
    return Container(
      margin: EdgeInsets.only(right: 5, top: 5, bottom: 5),
      alignment: Alignment.centerRight,
      //width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.blue[500],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
              border: Border.all(color: Colors.black,width: 2),
            ),
            child: Text(label, style: TextStyle(fontSize: 15),),
          ),
          Text("${dateTime.day}/${dateTime.month}/${dateTime.year}, ${DateFormat.jm().format(dateTime)}", style: TextStyle(fontSize: 12),)
        ],
      ),
    );
  }

  Widget receivedMessage(String label, DateTime dateTime) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5, bottom: 5),
      alignment: Alignment.centerLeft,
     // width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              border: Border.all(color: Colors.black,width: 2),
            ),
            child: Text(label ?? "", style: TextStyle(fontSize: 15)),
          ),
          Text("${dateTime.day}/${dateTime.month}/${dateTime.year}, ${DateFormat.jm().format(dateTime)}", style: TextStyle(fontSize: 12),)
        ],
      ),
    );
  }

}

