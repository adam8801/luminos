import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/comListModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class Comment extends StatefulWidget {

  final String id;
  Comment({this.id});
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  bool circularState = true;
  TextEditingController _subject = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  ComListModel comListModel = ComListModel();
  FlutterSecureStorage storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String tagname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      tagname = await storage.read(key: "tagname");
      Map<String, String> body = {
        "id" : widget.id
      };
      var response = await networkHandler.post("/blog/comments", body);
      if(response.statusCode == 200 || response.statusCode == 201){
        comListModel = ComListModel.fromJson(json.decode(response.body)["data"]);
      }else{
        Map<String, dynamic> output = json.decode(response.body);
        showAlertDialog(context, output["msg"]);
      }
      setState(() {
        comListModel.comment = new List.from(comListModel.comment.reversed);
        circularState = false;
      });
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
              child: circularState ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    writeSpace(context),
                    SizedBox(height: 10,),
                    comListModel.comment.isNotEmpty ? Column(
                      children: comListModel.comment.map((link) => commentTile(context, DateTime.parse(link.postedAt).toLocal(), link.subject, link.from, link.by)).toList(),
                    ) : Container(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.white),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                )
              )
            )
    );
  }

  Widget commentTile(BuildContext context ,DateTime dateTime ,String subject, String name, String by) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: boxDecoration(Colors.white, 10, Colors.black, 2, Colors.black),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Datetime - ${dateTime.day}/${dateTime.month}/${dateTime.year}, ${DateFormat.jm().format(dateTime)}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5,),
          Text(subject),
          SizedBox(height: 5,),
          Text(name ?? "a"),
          SizedBox(height: 5,),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(tagname: by))
              );
            },
              child: Text("See the writer", style: TextStyle(color: Colors.blue, fontSize: 12, fontStyle: FontStyle.italic),)
          ),
          by == tagname ?
          IconButton(
            onPressed: () async {
              try{
                Map<String, String> body = {
                  "id" : widget.id,
                  "subject" : subject,
                  "from" : _name.text
                };
                var response = await networkHandler.patch("/blog/downVote/c", body);
                if(response.statusCode == 200 || response.statusCode == 201) {
                  showAlertDialog(context, "Deleted");
                }else{
                  Map<String, dynamic> output = json.decode(response.body);
                  showAlertDialog(context, output["msg"]);
                }
              }catch(e){
                showAlertDialog(context, "Some error occurred");
              }
            },
            icon: Icon(Icons.delete),
          )
             : Container()
        ],
      ),
    );
  }

  Widget writeSpace(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10,),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: boxDecoration(Colors.white, 10, Colors.black, 2, Colors.black),
      child: Column(
        children: [
          TextFormField(
            maxLengthEnforced: true,
            maxLength: 50,
            controller: _subject,
            maxLines: null,
            style: TextStyle(color: Colors.black),
            decoration: textFormDecoration("Write a comment", "", Icons.edit),
          ),
          SizedBox(height: 10),
          TextFormField(
            maxLengthEnforced: true,
            maxLength: 40,
            controller: _name,
            maxLines: null,
            style: TextStyle(color: Colors.black),
            decoration: textFormDecoration("Write your name", "", Icons.person),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: boxDecoration(Colors.teal, 10, Colors.black, 2, Colors.black),
                  child: FlatButton.icon(
                    onPressed: () async {
                      try{
                        if(_subject.text != "" && _name.text != "") {
                          Map<String, String> body = {
                            "id" : widget.id,
                            "subject" : _subject.text,
                            "from" : _name.text
                          };
                          var response = await networkHandler.patch("/blog/upVote/c", body);
                          if(response.statusCode == 200 || response.statusCode == 201) {
                            FocusScope.of(context).unfocus();
                            _name.clear();
                            _subject.clear();
                            fetchData();
                            showAlertDialog(context, "Posted");
                          }else{
                            Map<String, dynamic> output = json.decode(response.body);
                            showAlertDialog(context, output["msg"]);
                          }
                        }else{
                          showAlertDialog(context, "Please fill out the given fields");
                        }
                      }catch(e){
                        showAlertDialog(context, "Some error occurred");
                      }
                    },
                    label: Text("Post"),
                    icon: Icon(Icons.send,),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

}
