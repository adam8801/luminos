import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';

class ShowProfile extends StatelessWidget {

  final List<String> hobbies;
  final List<String> education;
  final List<String> work;
  final List<String> achievements;
  final List<String> projects;
  final String name;
  final String about;
  final int gender;
  final String currentDesignation;
  final String location;
  final String dob;
  ShowProfile({this.hobbies, this.education, this.work, this.achievements, this.projects, this.name, this.about, this.gender, this.currentDesignation, this.location, this.dob});

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
                              child: Center(child: Text("$name Profile", style: TextStyle(fontSize: 20, color: Colors.white),)),
                            ),
                          ),
                          SizedBox(height: 20,),
                          currentDesignation != null ? Text("Current Designation  -\n $currentDesignation",style: TextStyle(fontSize: 18, color: Colors.blue[900]),) : Container(),
                          SizedBox(height: 10,),
                          location != null ? Text("Current Location -\n $location",style: TextStyle(fontSize: 18, color: Colors.blue[900]),) : Container(),
                          SizedBox(height: 10,),
                          gender == 0 ? Text("Gender - \nMale",style: TextStyle(fontSize: 18, color: Colors.blue[900]),) : gender == 1 ? Text("Gender -\n Female",style: TextStyle(fontSize: 18, color: Colors.blue[900]),) : Text("Gender -\n Other",style: TextStyle(fontSize: 18, color: Colors.blue[900]),) ,
                          SizedBox(height: 10,),
                          Text("DOB (MM/DD/YYYY) - \n$dob",style: TextStyle(fontSize: 18, color: Colors.blue[900]),),
                          SizedBox(height: 10,),
                          hobbies.isNotEmpty ? Text("Hobbies :",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),) : Container(),
                          hobbies.isNotEmpty ? Column(
                            children: hobbies.map((link) => Text(link,style: TextStyle(color: Colors.blue[900]),)).toList(),
                          ) : Container(),
                          SizedBox(height: 10,),
                          education.isNotEmpty ? Text("Education :",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),) : Container(),
                          education.isNotEmpty ? Column(
                            children: education.map((link) => Text(link, style: TextStyle(color: Colors.blue[900]),)).toList(),
                          ) : Container(),
                          SizedBox(height: 10,),
                          work.isNotEmpty ? Text("Work Experience :",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),) : Container(),
                          work.isNotEmpty ? Column(
                            children: work.map((link) => Text(link, style: TextStyle(color: Colors.blue[900]),)).toList(),
                          ) : Container(),
                          SizedBox(height: 10,),
                          projects.isNotEmpty ? Text("Projects :",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),) : Container(),
                          projects.isNotEmpty ? Column(
                            children: projects.map((link) => Text(link, style: TextStyle(color: Colors.blue[900]),)).toList(),
                          ) : Container(),
                          SizedBox(height: 10,),
                          achievements.isNotEmpty ? Text("Achievements :",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),) : Container(),
                          achievements.isNotEmpty ? Column(
                            children: achievements.map((link) => Text(link, style: TextStyle(color: Colors.blue[900]),)).toList(),
                          ) : Container(),
                          SizedBox(height: 10,),
                          Text("About",style: TextStyle(fontSize: 22, decoration: TextDecoration.underline, color: Colors.blue[900]),),
                          about != null ? Text(about, style: TextStyle(color: Colors.blue[900]),) : Container(),
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
                        ]
                    )
                )
            )
        )
    );
  }
}
