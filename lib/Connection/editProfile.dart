import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/customUi/addText.dart';
import 'package:network_2/customUi/inputField.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool circularState = true;
  TextEditingController _status = new TextEditingController();
  TextEditingController _designation = new TextEditingController();
  TextEditingController _location = new TextEditingController();
  TextEditingController _about = new TextEditingController();
  int _freeze ;
  int _privateKey ;
  List<String> _projects = [];
  List<String> _education = [];
  List<String> _hobbies = [];
  List<String> _work = [];
  List<String> _achievements = [];
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String tagname;
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      tagname = await storage.read(key: "tagname");
      var response = await networkHandler.get("/profile/getMyData");
      setState(() {
        profileModel = ProfileModel.fromJson(response["data"]);
        _status.text = profileModel.status;
        _designation.text = profileModel.currentDesignation;
        _location.text = profileModel.location;
        _about.text = profileModel.about;
        _freeze = profileModel.freeze;
        _privateKey = profileModel.privateKey;
        _projects = profileModel.projects;
        _education = profileModel.education;
        _hobbies = profileModel.hobbies;
        _work = profileModel.work;
        _achievements = profileModel.achievements;
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
                        child: Center(child: Text("Edit Profile", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    _imageFile == null ? imageProfile() : imageProfile1(),
                    SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "Status", "", _status, 50, Icons.star_border_purple500_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "Current Designation (Student, employee, professor etc.)", "", _designation, 50, Icons.perm_identity),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "Current Location", "", _location, 50, Icons.location_city),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: inputField(context, BoxDecoration(), "About", "", _about, 250, Icons.description),
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
                          Text("Choose type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          ListTile(
                            title: Text("Student"),
                            leading: Radio(
                              value: 0,
                              autofocus: _freeze == 0 ? true : false,
                              groupValue: _freeze,
                              onChanged: (val) {
                                setState(() {
                                  _freeze = val;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Text("Non-Student"),
                            leading: Radio(
                              value: 1,
                              groupValue: _freeze,
                              onChanged: (val) {
                                setState(() {
                                  _freeze = val;
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
                          Text("Choose account type", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                          ListTile(
                            title: Text("Public (Anyone can see your posts)"),
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
                          ),
                          ListTile(
                            title: Text("Private (Only your connections can see your posts)"),
                            leading: Radio(
                              value: 1,
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: dropBox(_projects, "Projects")
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: dropBox(_education, "Education")
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: dropBox(_hobbies, "Hobbies")
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: dropBox(_work, "Work Experience")
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: dropBox(_achievements, "Achievements")
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
              )
            )
          )
    );
  }

  Widget imageProfile1(){
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: FileImage(File(_imageFile.path)),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.blue,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageProfile(){
    return Center(
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                NetworkHandler().getImageUrlPr(tagname)+"?v=${Random().nextInt(100)}",
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Image.asset("assets/pageCover1.jpg",fit: BoxFit.fill,);
                },
              )
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.blue,
                size: 28.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Choose Profile Photo (Max 2 MB)", style: TextStyle( fontSize: 20 ),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera")
              ),
              FlatButton.icon(
                  onPressed: (){
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery")
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget dropBox(List<String> list, String label) {
      return InkWell(
        onTap: (){
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (builder) => Container(
                height: MediaQuery.of(context).size.height-150,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: addMultipleStrings(links: list, label: label)
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue[700],width: 2)
            ),
            child: Center(child: Text(label, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
        ),
      );
  }

  Widget send() {
    return InkWell(
      onTap: () async {
        try{
          if(_hobbies.length < 11 && _work.length < 11 && _achievements.length < 11 && _projects.length < 11 && _education.length < 11){
            setState(() {
              circularState = true;
            });
            Map<String, dynamic> data = {
              "status" : _status.text ?? "",
              "currentDesignation" : _designation.text ?? "",
              "location" : _location.text ?? "",
              "hobbies" : _hobbies,
              "work" : _work,
              "achievements" : _achievements,
              "about" : _about.text ?? "",
              "freeze" : _freeze,
              "privateKey" : _privateKey,
              "projects" : _projects,
              "education" : _education
            };
            var response = await networkHandler.patchD("/profile/update", data);
            if(response.statusCode == 200 || response.statusCode == 201){
              if(_imageFile != null) {
                var imageResponse = await networkHandler.patchImage("/profile/addImage", _imageFile.path);
                if(imageResponse.statusCode == 200 || imageResponse.statusCode == 201){
                  Navigator.pop(context);
                }else{
                  showAlertDialog(context, "Image upload failed");
                }
              }else{
                Navigator.pop(context);
              }
            }else{
              Map<String, dynamic> output = json.decode(response.body);
              showAlertDialog(context, output["msg"]);
            }
            setState(() {
              circularState = false;
            });
          }else{
            showAlertDialog(context, "Follow the rules while filling the data");
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