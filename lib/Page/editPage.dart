import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class EditPage extends StatefulWidget {
  final String subtitle;
  final String about;
  final int privateKey;
  final int allPost;
  final String pagename;
  EditPage({this.subtitle, this.about, this.privateKey, this.allPost, this.pagename});
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  bool circularState = false;
  TextEditingController _subtitle = new TextEditingController();
  TextEditingController _about = new TextEditingController();
  int _privateKey ;
  int _allPost;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      _subtitle.text = widget.subtitle;
      _about.text = widget.about;
      _allPost = widget.allPost;
      _privateKey = widget.privateKey;
    });
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
                          child: Center(child: Text("Edit Page Info", style: TextStyle(fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: inputField(context, BoxDecoration(), "Subtitle", "", _subtitle, 40, Icons.polymer),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: inputField(context, BoxDecoration(), "About", "", _about, 150, Icons.description),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue[700],width: 2)
                        ),
                        child: Column(
                          children: [
                            Text("Is this a private page", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Text("Private pages can only be viewed by its members"),
                            ListTile(
                              title: Text("Yes"),
                              leading: Radio(
                                value: 1,
                                groupValue: _privateKey,
                                onChanged: (val) {
                                  setState(() {
                                    _privateKey = val;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("No"),
                              leading: Radio(
                                value: 0,
                                autofocus: _privateKey == 0 ? true : false,
                                groupValue: _privateKey,
                                onChanged: (val) {
                                  setState(() {
                                    _privateKey = val;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue[700],width: 2)
                        ),
                        child: Column(
                          children: [
                            Text("Who can post blog", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                            ListTile(
                              title: Text("Both members and admins"),
                              leading: Radio(
                                value: 1,
                                autofocus: _allPost == 1 ? true : false,
                                groupValue: _allPost,
                                onChanged: (val) {
                                  setState(() {
                                    _allPost = val;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: Text("Only admins"),
                              leading: Radio(
                                value: 0,
                                groupValue: _allPost,
                                onChanged: (val) {
                                  setState(() {
                                    _allPost = val;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(child: send()),
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
                  ),
                )
            )
        )
    );
  }

  Widget send() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: boxDecoration(Colors.teal, 10, Colors.black, 2, Colors.black),
        child: FlatButton.icon(
          onPressed: () async {
            try{
              Map<String, dynamic> data = {
                "subtitle" : _subtitle.text ?? "",
                "about" : _about.text ?? "",
                "privateKey" : _privateKey,
                "allPost" : _allPost,
                "pagename" : widget.pagename
              };
              var response = await networkHandler.patchD("/page/edit", data);
              if(response.statusCode == 200 || response.statusCode == 201) {
                showAlertDialog(context, "Updated");
              }else{
                Map<String, dynamic> output = json.decode(response.body);
                showAlertDialog(context, output["msg"]);
              }
            }catch(e){
              print(e.toString());
              showAlertDialog(context, "Some error occurred");
            }
          },
          label: Text("Update"),
          icon: Icon(Icons.send,),
        )
    );
  }

}
