import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<FeedBack> {

  bool circularState = true;
  TextEditingController _feedback = new TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  var d = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      var response = await networkHandler.get("/profile/getFeedback");
      setState(() {
        if(response != null){
          _feedback.text = response["data"]["feed"];
        }
        circularState = false;
      });
    }catch(e){
      print(e.toString());
      showAlertDialog(context, "Network Error");
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
                child: circularState ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
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
                          child: Center(child: Text("Feedback", style: TextStyle(fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: inputField(context, BoxDecoration(), "Feedback", "", _feedback, 500, Icons.description),
                      ),
                      SizedBox(height: 20,),
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
                ),
              )
            )
           );
  }

  Widget send() {
    return InkWell(
      onTap: () async {
        try{
          if(_feedback.text != ""){
            setState(() {
              circularState = true;
            });
            Map<String, String> data = {
              "feed" : _feedback.text ?? ""
            };
            var response = await networkHandler.patch("/profile/postFeedback", data);
            if(response.statusCode == 200 || response.statusCode == 201){
              Map<String, dynamic> output = json.decode(response.body);
              showAlertDialog(context, output["msg"]);
              setState(() {
                circularState = false;
              });
            }else{
              Map<String, dynamic> output = json.decode(response.body);
              showAlertDialog(context, output["msg"]);
              setState(() {
                circularState = false;
              });
            }
          }else{
            showAlertDialog(context, "Can't post empty");
          }
        }catch(e){
          setState(() {
            circularState = false;
          });
          showAlertDialog(context, "Some error occurred");
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text("Update", style: TextStyle(color: Colors.white)),
      ),
    );
  }

}
