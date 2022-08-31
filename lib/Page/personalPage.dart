import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_2/Models/pageModel.dart';
import 'package:network_2/Page/editPage.dart';
import 'package:network_2/Page/personList.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class PersonalPage extends StatefulWidget {

  final String pagename;
  final String subtitle;
  final List<String> members;
  final int level;
  PersonalPage({this.pagename, this.subtitle, this.members, this.level});

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {

  bool circularState = true;
  bool imageLoader = false;
  NetworkHandler networkHandler = NetworkHandler();
  PageModel pageModel = PageModel();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      Map<String, String> body = {
        "pagename" : widget.pagename
      };
      var response = await networkHandler.post("/page/getPersonalData", body);
      if( response.statusCode == 200 || response.statusCode == 201){
        setState(() {
          pageModel = PageModel.fromJson((json.decode(response.body))["data"]);
          circularState = false;
        });
      }else{
        showAlertDialog(context, "error");
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
            child: circularState ? Center(child: CircularProgressIndicator()) : ListView(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5,),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: boxDecoration(Colors.white, 20, Colors.black, 2, Colors.black),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          left: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                            ),
                          ),
                        ),
                        _imageFile == null ? imageProfile() : imageProfile1(),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 28.0,
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: boxDecoration(Colors.white, 15, Colors.blue[900], 2, Colors.blue[200]),
                    child: Text("${widget.pagename} - ${widget.subtitle}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonList(label: "Admins", type: 1, list: pageModel.admins, pagename: widget.pagename,)));
                            },
                            child: Text("Admins", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonList(label: "Members", type: 2, list: pageModel.members, pagename: widget.pagename,)));
                            },
                            child: Text("Members", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PersonList(label: "Requests", type: 3, list: pageModel.rmembers, pagename: widget.pagename,)));
                            },
                            child: Text("Requests", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                  child: FlatButton.icon(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPage(subtitle: pageModel.subtitle, about: pageModel.about, allPost: pageModel.allPost, privateKey: pageModel.privateKey, pagename: pageModel.pagename,)
                          )
                      );
                    },
                    icon: Icon(Icons.edit),
                    label: Text("Edit Page info", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                ),
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
                NetworkHandler().getImageUrlPa(widget.pagename)+"?v=${Random().nextInt(100)}",
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Image.asset("assets/pageCover1.jpg",fit: BoxFit.fill,);
                },
              )
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return imageLoader ? CircularProgressIndicator() : Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Choose Page Photo (Max 2 MB)", style: TextStyle( fontSize: 20 ),),
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
          ),
          FlatButton(
            onPressed: () async {
              try{
                setState(() {
                  imageLoader = true;
                });
                if(_imageFile != null){
                  var imageResponse = await networkHandler.patchImageWC("/page/addImage", _imageFile.path, widget.pagename);
                  if(imageResponse.statusCode == 200 || imageResponse.statusCode == 201){
                    setState(() {
                      imageLoader = false;
                    });
                    showAlertDialog(context, "Image uploaded");
                  }else{
                    setState(() {
                      imageLoader = false;
                    });
                    showAlertDialog(context, "Image upload failed");
                  }
                }else{
                  setState(() {
                    imageLoader = false;
                  });
                  showAlertDialog(context, "failed");
                }
              }catch(e){
                setState(() {
                  imageLoader = false;
                });
                showAlertDialog(context, "Some error occurred");
              }
            },
            child: Text(" Submit "),
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

}

