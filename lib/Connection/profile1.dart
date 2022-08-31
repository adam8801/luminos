import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:network_2/Connection/chat.dart';
import 'package:network_2/Connection/showProfile.dart';
import 'package:network_2/Connection/showSkills.dart';
import 'package:network_2/Models/blListModel.dart';
import 'package:network_2/Models/blogModel.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/Page/comment.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/listTable.dart';
import 'package:network_2/networkHandler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {

  final String tagname;
  ProfilePage({this.tagname});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ProfileModel profileModel = ProfileModel();
  NetworkHandler networkHandler = NetworkHandler();
  FlutterSecureStorage storage = FlutterSecureStorage();
  bool circularState = true;
  bool loadState = false;
  String tagname;
  List<String> pages = [];
  BlListModel blogList = BlListModel();
  BlListModel blogList1 = BlListModel();
  List<BlogModel> data = [];
  List<BlogModel> data1 = [];
  int val = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() {
    fetchData1();
    fetchData2();
  }

  void fetchData1() async {
    try{
        Map<String, String> body = {
          "tagname" : widget.tagname
        };
        var response = await networkHandler.post("/profile/getOthersData", body);
        var response1 = json.decode(response.body);
        tagname = await storage.read(key: "tagname");
        setState(() {
          profileModel = ProfileModel.fromJson(response1["data"]);
          pages = profileModel.pages + profileModel.created;
          circularState = false;
        });
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  void fetchData2() async {
    try{
      Map<String, String> body = {
        "tagname" : widget.tagname
      };
      var response = await networkHandler.post("/blog/getOthersPost/0", body);
      if(response.statusCode == 200 || response.statusCode == 201){
        blogList = BlListModel.fromJson(json.decode(response.body));
        setState(() {
          data = blogList.data;
          circularState = false;
          val = 0;
        });}else{
        Map<String, dynamic> output = json.decode(response.body);
        showAlertDialog(context, output["msg"]);
        setState(() {
          circularState = false;
        });
      }
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  void fetchData3() async {
    try{
      setState(() {
        val = val + 5;
        loadState = true;
      });
      Map<String, String> body = {
        "tagname" : widget.tagname
      };
      var response = await networkHandler.post("/blog/getOthersPost/${val.toString()}", body);
      blogList1 = BlListModel.fromJson(json.decode(response.body));
        if(blogList1.data.isNotEmpty){
          setState(() {
            data1 = blogList1.data;
            data = data + data1;
            loadState = false;
          });
        }else{
          showAlertDialog(context, "No more blog available");
          setState(() {
            loadState = false;
          });
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
            child: ListView(
              children: [
                Container(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5,),
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: boxDecoration(Colors.white, 20, Colors.black, 2, Colors.black),
                  child: circularState ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(NetworkHandler().getImageUrlPr(widget.tagname)+"?v=${Random().nextInt(100)}",
                              fit: BoxFit.fill,
                              errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                return Image.asset("assets/pageCover1.jpg",fit: BoxFit.fill,);
                              },
                            )
                        ),
                        Positioned(
                          top: 5,
                          left: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50.0,
                          left: 10.0,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: profileModel.level == null ? Colors.white : profileModel.level > 0 ? profileModel.level == 2 ? Colors.blue[800] : Colors.teal : Colors.black,
                              child: Icon(Icons.check, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: boxDecoration(Colors.white, 10, Colors.blue[900], 2, Colors.blue[200]),
                    child: Center(child: Text("${profileModel.name ?? ""}",  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("\"${profileModel.status ?? ""}\"", style: TextStyle(color: Colors.blue[900]),)),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: profileModel.connections == null ? Container() : profileModel.connections.contains(tagname) ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,),
                        decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                        child: FlatButton(
                          onPressed: () async {
                            try{
                              Map<String, String> body = {
                                "tagname" : widget.tagname
                              };
                              var response = await networkHandler.patch("/profile/disconnect", body);
                              if(response.statusCode == 200 || response.statusCode == 201) {
                                Navigator.pop(context);
                              }else{
                                Map<String, dynamic> output = json.decode(response.body);
                                showAlertDialog(context, output["msg"]);
                              }
                            }catch(e){
                              showAlertDialog(context, "Some error occurred");
                            }
                          },
                          child: Text("Disconnect", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                      ) : Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,),
                        decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                        child: FlatButton(
                          onPressed: () async {
                            try{
                              Map<String, String> body = {
                                "tagname" : widget.tagname
                              };
                              var response = await networkHandler.patch("/profile/request", body);
                              if(response.statusCode == 200 || response.statusCode ==201){
                                Map<String, dynamic> output = json.decode(response.body);
                                showAlertDialog(context, output["msg"]);
                              }else{
                                Map<String, dynamic> output = json.decode(response.body);
                                showAlertDialog(context, output["msg"]);
                              }
                            }catch(e){
                              showAlertDialog(context, "Some error occurred");
                            }
                          },
                          child: Text("Connect", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(tagname1: widget.tagname, tagname2: tagname,)));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: boxDecoration(Colors.white, 10, Colors.black, 2, Colors.black),
                          child: Icon(Icons.message, color: Colors.blue[900], size: 35,)
                      ),
                    ),
                    SizedBox(width: 5,)
                  ],
                ),
                SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowProfile(hobbies: profileModel.hobbies, education: profileModel.education, work: profileModel.work, achievements: profileModel.achievements, projects: profileModel.projects, name: profileModel.name, about: profileModel.about, gender: profileModel.gender, currentDesignation: profileModel.currentDesignation, location: profileModel.location, dob: profileModel.dob,)
                                  )
                              );
                            },
                            child: Text("Profile", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ListTable(label: "Connections", list: profileModel.connections, type: 1,)));
                            },
                            child: Text("Connections", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ListTable(label: "Pages", list: pages, type: 2,)));
                            },
                            child: Text("Pages", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                          ),
                        ),
                        SizedBox(width: 10),
                        profileModel.freeze == 0 ? Center(
                          child: Container(
                            decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                            child: FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSkills(tagname: widget.tagname, name: profileModel.name, others: true,)));
                              },
                              child: Text("Skills", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                ),
                pageCard(context),
              ],
            )
        ),
      ),
    );
  }

  Widget pageCard(BuildContext context) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              setState(() {
                circularState = true;
              });
              fetchData2();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: boxDecoration(Colors.white , 20, Colors.black, 2, Colors.black),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.teal,
                child: Icon(Icons.refresh, size: 25, color: Colors.black),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        circularState ? CircularProgressIndicator() : data == [] || data == null ? Container() : blogs(),
        loadState ? CircularProgressIndicator() : moreTab("More"),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.blue[900]),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.blue[900]),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.blue[900]),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.blue[900]),),
        ),
      ],
    );
  }

  Widget blogs() {
    return Container(
      child: Column(
        children: data.map((item) => blog(item.id, item.writer, item.reports, item.post, item.links, item.heart,item.like,item.share, DateTime.parse(item.dateTime).toLocal(), item.flag, item.commentNew)).toList(),
      ),
    );
  }

  Widget blog(String id, String writer, List<String> reports, String post, List<String> links, List<String> heart, List<String> like, List<String> share, DateTime dateTime, int flag, int commentNew) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: boxDecoration(Colors.white, 10, Colors.black, 2, Colors.black),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}, ${DateFormat.jm().format(dateTime)}"),
              ),
              popUp2(context, id, writer, reports),
              Text("Blog"),
            ],
          ),
          flag == 1 ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(NetworkHandler().getImageUrlB(id),
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                  return Container();
                },
              )
          ) : Container(),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post ?? "",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 10,),
                RichText(
                  textAlign: TextAlign.start,
                  text: links.isNotEmpty ? TextSpan(
                    children: links.map((link) => linkTile(link)).toList(),
                  ) : TextSpan(text: "",),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        try{
                          if(heart.contains(tagname)){
                            Map<String, String> body = {
                              "id" : id
                            };
                            var response = await networkHandler.patch("/blog/downVote/h", body);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                heart.remove(tagname);
                              });
                              showAlertDialog(context, "Done");
                            }else{
                              showAlertDialog(context, "Error");
                            }
                          }else{
                            Map<String, String> body = {
                              "id" : id
                            };
                            var response = await networkHandler.patch("/blog/upVote/h", body);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                heart.add(tagname);
                              });
                              showAlertDialog(context, "Done");
                            }else{
                              showAlertDialog(context, "Error");
                            }
                          }
                        }catch(e){
                          showAlertDialog(context, "Some error occurred");
                        }
                      },
                      icon: Icon(
                          Icons.favorite ,size: 15, color: heart.contains(tagname) ? Colors.red[900] : Colors.black
                      ),
                    ),
                    Text( heart != null ? heart.length.toString() : "0"),
                    IconButton(
                      onPressed: () async {
                        try{
                          if(like.contains(tagname)){
                            Map<String, String> body = {
                              "id" : id
                            };
                            var response = await networkHandler.patch("/blog/downVote/l", body);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                like.remove(tagname);
                              });
                              showAlertDialog(context, "Done");
                            }else{
                              showAlertDialog(context, "Error");
                            }
                          }else{
                            Map<String, String> body = {
                              "id" : id
                            };
                            var response = await networkHandler.patch("/blog/upVote/l", body);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                like.add(tagname);
                              });
                              showAlertDialog(context, "Done");
                            }else{
                              showAlertDialog(context, "Error");
                            }
                          }
                        }catch(e){
                          showAlertDialog(context, "Some error occurred");
                        }
                      },
                      icon: Icon(
                          Icons.thumb_up,size: 15, color: like.contains(tagname) ? Colors.blue : Colors.black
                      ),
                    ),
                    Text( like != null ? like.length.toString() : "0"),
                    IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(id: id,)));
                      },
                      icon: Icon(
                          Icons.comment,size: 15, color: commentNew == 1 ? Colors.blue : Colors.black
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        try{
                          if(!share.contains(tagname)){
                            Map<String, String> body = {
                              "id" : id
                            };
                            var response = await networkHandler.patch("/blog/upVote/s", body);
                            if(response.statusCode == 200 || response.statusCode == 201){
                              setState(() {
                                share.add(tagname);
                              });
                            }
                          }
                          final RenderBox box = context.findRenderObject();
                          Share.share(
                              post+"\n"+links.toString(),
                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                          );
                        }catch(e){
                          showAlertDialog(context, "Some error occurred");
                        }
                      },
                      icon: Icon(
                          Icons.share,size: 15
                      ),
                    ),
                    Text( share != null ? share.length.toString() : "0"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget popUp2(BuildContext context, String id, String writer, List<String> reports) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        try{
          Map<String, String> body = {
            "blogId" : id
          };
          var response = await networkHandler.patch("/blog/report", body);
          if(response.statusCode == 200 || response.statusCode == 201) {
            showAlertDialog(context, "Done");
            fetchData2();
          }else{
            Map<String, dynamic> output = json.decode(response.body);
            showAlertDialog(context, output["msg"]);
          }
        }catch(e){
          showAlertDialog(context, "Some error occurred");
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text("Report this post-  ${reports.length}"),
            value: "Report",
          ),
        ];
      },);
  }

  InlineSpan linkTile(String link) {
    return TextSpan(
        text: "\n $link",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        recognizer: TapGestureRecognizer()..onTap = () async {
          var url = link;
          if( await canLaunch(url)) {
            await launch(url);
          }else{
            showAlertDialog(context, "Can't load the link");
          }
        }
    );
  }

  Widget moreTab(String label) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 15,
      color: Colors.teal,
      child: FlatButton(
          onPressed: (){
            fetchData3();
          },
          child: Column(children: [Text(label), Icon(Icons.arrow_drop_down)],)
      ),
    );
  }

}
