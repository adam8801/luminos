import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_2/Screens/homeScreen.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  bool circularState = false;
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  bool sW = false;
  bool rP = true;
  String token;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black,width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: circularState ? Center(child: CircularProgressIndicator()) : ListView(
        children: [
          sW ? secondWindow() :  Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10,),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    inputField1(context, "Username", "*", _username, 15, Icons.person),
                    SizedBox(height: 20,),
                    passwordField(),
                    SizedBox(height: 40,),
                    send(),
                    SizedBox(height: 40,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          sW = true;
                        });
                      },
                      child: Text("Forgot Password ?",
                        style: TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 2, decoration: TextDecoration.underline),
                      ),
                    ),
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
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget passwordField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white,width: 8),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          maxLengthEnforced: true,
          maxLength: 15,
          controller: _password,
          validator: (value) {
            if(value.isEmpty){
              return "Field can't be empty";
            }
            return null;
          },
          obscureText: true,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: "Password",
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue[900],
                  width: 2,
                )
            ),
            prefixIcon: Icon(Icons.lock, color: Colors.blue[900],),
          ),
        )
    );
  }

  Widget send() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(50),
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
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.transparent,
        child:IconButton(
          onPressed: () async {
            try{
              setState(() {
                circularState = true;
              });
              if(_formKey.currentState.validate()){
                Map<String, String> data = {
                  "username" : _username.text,
                  "password" : _password.text
                };
                var response = await networkHandler.post1("/user/login", data);
                if(response.statusCode == 200 || response.statusCode == 201) {
                  Map<String, dynamic> output = json.decode(response.body);
                  await storage.write(key: "token", value: output["token"]);
                  await storage.write(key: "tagname", value: output["tagname"]);
                  await storage.write(key: "freeze", value: output["freeze"]);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                          (route) => false
                  );
                }else{
                  Map<String, dynamic> output = json.decode(response.body);
                  final snackBar1 = SnackBar(
                    content: Text(output["msg"]),
                    duration: Duration(seconds: 5),
                  );
                  Scaffold.of(context).showSnackBar(snackBar1);
                  setState(() {
                    circularState = false;
                  });
                }
              }else{
                setState(() {
                  circularState = false;
                });
              }
            }catch(e){
              final snackBar = SnackBar(
                content: Text("Some error occurred"),
                duration: Duration(seconds: 5),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              setState(() {
                circularState = false;
              });
            }
          },
          icon: Icon(Icons.send, color: Colors.black, size: 35,),
        ),
      ),
    );
  }

  Widget secondWindow() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        child: Text("\nFor setting a new password please mail us with following details-\n\n1.Username-\n2.Tagname-\n3.Email-\n4.New_Password-\n\nPlease specify the subject of mail as Password Reset.",
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ),
    );
  }

}
