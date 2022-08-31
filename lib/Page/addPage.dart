import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Models/pageModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  bool circularState = false;
  TextEditingController _pagename = new TextEditingController();
  TextEditingController _subtitle = new TextEditingController();
  TextEditingController _about = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  int privateKey = 0;
  int allPost = 1;
  NetworkHandler networkHandler = NetworkHandler();

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
              child: circularState ? Center(child: CircularProgressIndicator()) : Form(
                key: formKey,
                child: SingleChildScrollView(
                child: Column(
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
                        child: Center(child: Text("New Page", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("“Creating pages is creating communities and sharing the skills, information and happiness with one another”", style: TextStyle(color: Colors.blue[900]),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "Page name", "*", _pagename, 40, Icons.pages_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "Subtitle", "*", _subtitle, 40, Icons.polymer),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "About", "*", _about, 150, Icons.description),
                    ),
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
                              groupValue: privateKey,
                              onChanged: (val) {
                                setState(() {
                                  privateKey = val;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("No"),
                            leading: Radio(
                              value: 0,
                              autofocus: true,
                              groupValue: privateKey,
                              onChanged: (val) {
                                setState(() {
                                  privateKey = val;
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
                              autofocus: true,
                              groupValue: allPost,
                              onChanged: (val) {
                                setState(() {
                                  allPost = val;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Only admins"),
                            leading: Radio(
                              value: 0,
                              groupValue: allPost,
                              onChanged: (val) {
                                setState(() {
                                  allPost = val;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("“In case you are creating this page for teaching purpose, please write us a mail so that we can help you achieve this goal”", style: TextStyle(color: Colors.blue[900]),),
                    ),
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
                ),
              ),
              ),
            ),
          )
      );
    }
  
  Widget send(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: boxDecoration(Colors.teal, 10, Colors.black, 2, Colors.black),
        child: FlatButton.icon(
          onPressed: () async {
            try{
              if(formKey.currentState.validate()) {
                setState(() {
                  circularState = true;
                });
                PageModel page = PageModel(pagename: _pagename.text, subtitle: _subtitle.text, about: _about.text, allPost: allPost, privateKey: privateKey);
                var response = await networkHandler.postBlog("/page/add", page.toJson());
                if(response.statusCode == 200 || response.statusCode == 201) {
                  setState(() {
                    circularState = false;
                  });
                  showAlertDialog(context, "Successfully created");
                }else{
                  Map<String, dynamic> output = json.decode(response.body);
                  showAlertDialog(context, output["msg"]);
                  setState(() {
                    circularState = false;
                  });
                }
              }else{
                showAlertDialog(context, "Please fill all the details");
              }
            }catch(e){
              showAlertDialog(context, "Some error occurred");
            }
          },
          label: Text("Create"),
          icon: Icon(Icons.send,),
        )
    );
  }
}