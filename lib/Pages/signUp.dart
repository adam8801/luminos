import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/networkHandler.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool circularState = false;
  bool otp = false;
  int gender = 0;
  int policy = 1;
  int freeze = 0;
  TextEditingController _name = new TextEditingController();
  TextEditingController _age = new TextEditingController();
  TextEditingController _status = new TextEditingController();
  TextEditingController _currentDesignation = new TextEditingController();
  TextEditingController _location = new TextEditingController();
  TextEditingController _dob = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _password1 = new TextEditingController();
  TextEditingController _tagname = new TextEditingController();
  TextEditingController _code = new TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  final _formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: otp ? otpWindow() : Column(
              children: [
                Text("Enter your details to get OTP", style: TextStyle(color: Colors.white),),
                SizedBox(height: 10,),
                inputField1(context, "Tag name", " * Tag name helps your friends\n to find you easily in the network", _tagname, 15, Icons.person),
                SizedBox(height: 20,),
                email(context, "Email", "*", _email, 40, Icons.email),
                SizedBox(height: 20,),
                inputField1(context, "Username", "*", _username, 15, Icons.person),
                SizedBox(height: 20,),
                policyField(),
                SizedBox(height: 40,),
                send(),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    setState(() {
                      otp = true;
                    });
                  },
                    child: Text("Click here to enter OTP and create your account",style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),)
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
        ],
      ),
    );
  }

  Widget email(BuildContext context, String label, String helper, TextEditingController controller, int val, IconData icon) {
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
          maxLength: val,
          controller: controller,
          validator: (value) {
            return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ?
            null : "Enter correct email";
          },
          maxLines: null,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: label,
            helperText: helper,
            helperStyle: TextStyle(color: Colors.red, fontSize: 12),
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
            prefixIcon: Icon(icon, color: Colors.blue[900],),
          ),
        )
    );
  }

  Widget freezeOption() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue[700],width: 2)
      ),
      child: Column(
        children: [
          Text("Choose type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
          ListTile(
            title: Text("Student"),
            leading: Radio(
              value: 0,
              autofocus: true,
              groupValue: freeze,
              onChanged: (val) {
                setState(() {
                  freeze = val;
                });
              },
            ),
          ),
          ListTile(
            title: Text("Non-Student"),
            leading: Radio(
              value: 1,
              groupValue: freeze,
              onChanged: (val) {
                setState(() {
                  freeze = val;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget genderField() {
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue[900], width: 2),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Text("Gender", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ListTile(
                title: Text("Male"),
                leading: Radio(
                  value: 0,
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Female"),
                leading: Radio(
                  value: 1,
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Others"),
                leading: Radio(
                  value: 2,
                  groupValue: gender,
                  onChanged: (val) {
                    setState(() {
                      gender = val;
                    });
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget policyField() {
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue[900], width: 2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Text("Do you agree to our terms of use and privacy policy"),
              SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Policies()));
                  },
                    child: Text("View",style: TextStyle(fontWeight: FontWeight.bold),)
                ),
              ),
              ListTile(
                title: Text("Yes"),
                leading: Radio(
                  value: 1,
                  autofocus: true,
                  groupValue: policy,
                  onChanged: (val) {
                    setState(() {
                      policy = val;
                    });
                    //print(gender);
                  },
                ),
              ),
              ListTile(
                title: Text("No"),
                leading: Radio(
                  value: 0,
                  groupValue: policy,
                  onChanged: (val) {
                    setState(() {
                      policy = val;
                    });
                    //print(gender);
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget dobField() {
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
          validator: (value) {
            if(value.isEmpty) {
              return "Field can't be empty";
            }else if(value.length != 10){
              return "use DD/MM/YYYY";
            }
            return null;
          },
          controller: _dob,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: "D.O.B(DD/MM/YYYY)",
            hintText: "DD/MM/YYYY",
            helperText: "*",
            helperStyle: TextStyle(color: Colors.red, fontSize: 12),
            hintMaxLines: 2,
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
            prefixIcon: Icon(Icons.person, color: Colors.blue[900],),
          ),
        )
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
          validator: (value) {
            if(value.isEmpty) {
              return "Field can't be empty";
            }
            return null;
          },
          controller: _password,
          obscureText: true,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: "Password",
            helperText: "*",
            helperStyle: TextStyle(color: Colors.red, fontSize: 12),
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

  Widget passwordField1() {
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
          validator: (value) {
            if(value.isEmpty) {
              return "Field can't be empty";
            }
            return null;
          },
          controller: _password1,
          obscureText: true,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: "Confirm Password",
            helperText: "*",
            helperStyle: TextStyle(color: Colors.red, fontSize: 12),
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

  Widget otpWindow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
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
                  controller: _code,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    labelText: "OTP",
                    helperText: "*",
                    helperStyle: TextStyle(color: Colors.red, fontSize: 12),
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
                    prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.blue[900],),
                  ),
                )
            ),
            SizedBox(height: 20,),
            inputField1(context, "Name", "*", _name, 40, Icons.person_outline_rounded),
            SizedBox(height: 20,),
            inputField1(context, "Status", "*", _status, 50, Icons.star_border_purple500_outlined),
            SizedBox(height: 20,),
            inputField1(context, "Age", "*", _age, 2, Icons.circle),
            SizedBox(height: 20,),
            freezeOption(),
            SizedBox(height: 20),
            genderField(),
            SizedBox(height: 20,),
            inputField1(context, "Current Designation", "*", _currentDesignation, 50, Icons.perm_identity),
            SizedBox(height: 20,),
            inputField1(context, "Current Location", "*", _location, 50, Icons.location_city),
            SizedBox(height: 20,),
            dobField(),
            SizedBox(height: 20,),
            email(context, "Email", "*", _email, 40, Icons.email),
            SizedBox(height: 20,),
            passwordField(),
            SizedBox(height: 20,),
            passwordField1(),
            SizedBox(height: 40,),
            submit(),
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
    );
  }

  Widget submit() {
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
              if(_formKey.currentState.validate() && _code.text.isNotEmpty && _password.text == _password1.text){
                Map<String, dynamic> data ={
                  "code" : int.parse(_code.text),
                  "password" : _password.text,
                  "email" : _email.text,
                  "name" : _name.text,
                  "status" : _status.text,
                  "age" : int.parse(_age.text),
                  "gender" : gender,
                  "currentDesignation" : _currentDesignation.text,
                  "location" : _location.text,
                  "dob" : _dob.text,
                  "freeze" : freeze
                };
                var response1 = await networkHandler.postRegister("/user/register", data);
                if(response1.statusCode == 200 || response1.statusCode == 201){
                  final snackBar1 = SnackBar(
                    content: Text("Account successfully created. Now you can login"),
                    duration: Duration(seconds: 8),
                  );
                  Scaffold.of(context).showSnackBar(snackBar1);
                  setState(() {
                    circularState = false;
                  });
                }else{
                  Map<String, dynamic> output = json.decode(response1.body);
                  final snackBar1 = SnackBar(
                    content: Text(output["msg"]),
                    duration: Duration(seconds: 8),
                  );
                  Scaffold.of(context).showSnackBar(snackBar1);
                  setState(() {
                    circularState = false;
                  });
                }}
              else{
                final snackBar1 = SnackBar(
                  content: Text("Empty otp or Password not matching"),
                  duration: Duration(seconds: 8),
                );
                Scaffold.of(context).showSnackBar(snackBar1);
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
              if(_tagname.text.isNotEmpty && _email.text.isNotEmpty && _username.text.isNotEmpty && policy == 1){
                  setState(() {
                    circularState = true;
                  });
                  Map<String, dynamic> data ={
                    "username" : _username.text,
                    "tagname" : _tagname.text,
                    "email" : _email.text
                  };
                  var response1 = await networkHandler.postRegister("/user/check", data);
                  if(response1.statusCode == 200 || response1.statusCode == 201){
                    setState(() {
                      circularState = false;
                    });
                    final snackBar1 = SnackBar(
                      content: Text("We will verify your credentials and send you the OTP through email after some time"),
                      duration: Duration(seconds: 10),
                    );
                    Scaffold.of(context).showSnackBar(snackBar1);
                  }else if(response1.statusCode == 403){
                    Map<String, dynamic> output = json.decode(response1.body);
                    final snackBar2 = SnackBar(
                      content: Text(output["msg1"]+" "+output["msg2"]+" "+output["msg3"], softWrap: true,),
                      duration: Duration(seconds: 10),
                    );
                    Scaffold.of(context).showSnackBar(snackBar2);
                    setState(() {
                      circularState = false;
                    });
                  }else{
                    Map<String, dynamic> output = json.decode(response1.body);
                    final snackBar1 = SnackBar(
                      content: Text(output["msg"]),
                      duration: Duration(seconds: 8),
                    );
                    Scaffold.of(context).showSnackBar(snackBar1);
                    setState(() {
                      circularState = false;
                    });
                  }
                }else{
                final snackBar1 = SnackBar(
                  content: Text("Please fill the details and agree to our policy"),
                  duration: Duration(seconds: 5),
                );
                Scaffold.of(context).showSnackBar(snackBar1);
                }
            }catch(e){
              final snackBar = SnackBar(
                content: Text("Some error occurred"),
                duration: Duration(seconds: 5),
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          },
          icon: Icon(Icons.send, color: Colors.black, size: 35,),
        ),
      ),
    );
  }

}

class Policies extends StatelessWidget {

  String a = "Steve Jobs said “Privacy means people know what they are signing up for in plain English and repeatedly” and that’s what we stand with but we also believe that users also plays an important role in the system and that is why we have certain rules or policies –";
  String b = "•	Since “Lucero” is a platform of ideas and innovations, everyone is allowed to express themselves but in a manner in which there is no harm to others’ reputation by misleading, and false statements.";
  String c = "•	Sharing of pornographic content is strictly prohibited.";
  String d = "•	Accounts can be suspended on observing suspicious or illegal activities.";
  String e = "•	Using the word “Lucero” is strictly prohibited apart form when referencing for its general meaning.";
  String f = "•	It is important that all users should follow the ethical and moral values while using the platform.";
  String g = "By using our product and services you agree to follow the terms or guidelines mentioned above, violation of any one or more terms will result in blocking of those individuals (or groups) from “Lucero” and could also face legal action by us.";

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
                          child: Center(child: Text("Terms of use and privacy policy", style: TextStyle(fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(a,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(b,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(c,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(d,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(e,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(f,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue[900], width: 2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(g,style: TextStyle(color: Colors.blue[900],fontSize: 18),)
                      ),
                      SizedBox(height: 10,),
                    ],
                  )
              )
          )
      ),
    );
  }
}

