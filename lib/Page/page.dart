import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/blListModel.dart';
import 'package:network_2/Models/blogModel.dart';
import 'package:network_2/Page/comment.dart';
import 'package:network_2/customUi/addText.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/customUi/listTable.dart';
import 'package:network_2/networkHandler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualPage extends StatefulWidget {
  final String pagename;
  final String subtitle;
  final List<String> members;
  IndividualPage({this.pagename, this.subtitle, this.members});

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {

  int viewType = 0;
  int val = 0;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  List<String> links = [];
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController post = TextEditingController();
  BlListModel blogList = BlListModel();
  BlListModel blogList1 = BlListModel();
  List<BlogModel> data = [];
  List<BlogModel> data1 = [];
  bool circularState = true;
  bool loadState = false;
  FlutterSecureStorage storage = FlutterSecureStorage();
  String tagname;
  List<dynamic> admins;
  String owner;
  String about;
  List<dynamic> reports;

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
      tagname = await storage.read(key: "tagname");
      Map<String, String> body1 = {
        "pagename" : widget.pagename
      };
      var response1 = await networkHandler.post("/page/getData", body1);
      Map<String, dynamic> response2 = json.decode(response1.body);
      setState(() {
        admins = response2["data"]["admins"];
        owner = response2["data"]["owner"];
        about = response2["data"]["about"];
        reports = response2["data"]["reports"];
        viewType = response2["data"]["level"];
      });
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  void fetchData2() async {
    try{
      Map<String, String> body = {
        "name" : widget.pagename
      };
      var response = await networkHandler.post("/blog/pageList/0", body);
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
        "name" : widget.pagename
      };
      var response = await networkHandler.post("/blog/pageList/${val.toString()}", body);
      blogList1 = BlListModel.fromJson(json.decode(response.body));
        if(blogList1.data.isNotEmpty){
          setState(() {
            post.text = "";
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
                child: SingleChildScrollView(
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
                              backgroundColor: viewType > 0 ? viewType == 2 ? Colors.blue[800] : Colors.teal : Colors.black,
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
                  decoration: boxDecoration(Colors.white, 15, Colors.blue[900], 2, Colors.blue[200]),
                  child: Center(child: Text("${widget.pagename} - ${widget.subtitle}", softWrap: true, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),))
              ),
              SizedBox(height: 10,),
              widget.members.contains(tagname) ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10,),
                decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                child: FlatButton(
                  onPressed: () async {
                    try{
                      Map<String, String> data = {
                        "pagename" : widget.pagename
                      };
                      var response = await networkHandler.patch("/page/disconnect", data);
                      if(response.statusCode == 200 || response.statusCode == 201){
                        showAlertDialog(context, "Successfully disconnected");
                        setState(() {
                          widget.members.remove(tagname);
                        });
                      }else{
                        showAlertDialog(context, "Some error occurred");
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
                      Map<String, String> data = {
                        "pagename" : widget.pagename
                      };
                      var response = await networkHandler.patch("/page/request", data);
                      if(response.statusCode == 200 || response.statusCode == 201){
                        showAlertDialog(context, "Request Send");
                      }else{
                        showAlertDialog(context, "Error occurred");
                      }
                    }catch(e){
                      showAlertDialog(context, "Some error occurred");
                    }
                  },
                  child: Text("Connect", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                ),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ListTable(label: "Admins", list: admins, type: 1,)));
                          },
                          child: Text("Admins", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                        child: FlatButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ListTable(label: "Members", list: widget.members, type: 1,)));
                          },
                          child: Text("Members", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        decoration: boxDecoration(Colors.blue[800], 10, Colors.black, 2, Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("More", style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),),
                            popUp1(context),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
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
        writeSpace(context),
        SizedBox(height: 10,),
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
                    post,
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
            maxLength: 500,
            controller: post,
            maxLines: null,
            style: TextStyle(color: Colors.black),
            decoration: textFormDecoration("Write a blog", "", Icons.edit),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: boxDecoration(Colors.white, 7, Colors.black, 2, Colors.black),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(context: context, builder: ((builder) => bottomSheet()));
                    },
                      icon: Icon(Icons.image_rounded, color: Colors.blue[900], size: 25),
                  )
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: boxDecoration(Colors.white, 7, Colors.black, 2, Colors.black),
                  child: IconButton(
                    onPressed: (){
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        ),
                        isScrollControlled: true,
                          context: context,
                          builder: (builder) => Container(
                              height: MediaQuery.of(context).size.height-150,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: addMultipleStrings(links: links, label: "Links")
                          ),
                      );
                    },
                      icon: Icon(Icons.add_link, color: Colors.blue[900], size: 25)
                  )
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  decoration: boxDecoration(Colors.teal, 10, Colors.black, 2, Colors.black),
                  child: FlatButton.icon(
                    onPressed: () async {
                      try{
                        if(post.text != "") {
                          BlogModel blog = BlogModel(name: widget.pagename, post: post.text, links: links, flag: _imageFile != null ? 1: 0);
                          var response = await networkHandler.postBlog("/blog/add/pa", blog.toJson());
                          if(response.statusCode == 200 || response.statusCode == 201) {
                            if(_imageFile != null){
                              Map<String, dynamic> output = json.decode(response.body);
                              print(output["id"]);
                              var response1 = await networkHandler.patchImageWC("/blog/addImage", _imageFile.path, output["id"]);
                              if(!(response1.statusCode == 200 || response1.statusCode == 201)){
                                showAlertDialog(context, "Image uploading failed");
                              }
                            }
                            setState(() {
                              FocusScope.of(context).unfocus();
                              _imageFile = null;
                              post.clear();
                              links = [];
                            });
                            showAlertDialog(context, "Posted");
                            fetchData2();
                          }else{
                            Map<String, dynamic> output = json.decode(response.body);
                            showAlertDialog(context, output["msg"]);
                          }
                        }else{
                          showAlertDialog(context, "Can't post empty");
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

  InlineSpan linkTile(String link) {
    return TextSpan(
        text: "\n $link",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue[900]),
        recognizer: TapGestureRecognizer()..onTap = () async {
          var url = link;
          if( await canLaunch(url)) {
            await launch(url);
          }else{
            showAlertDialog(context, "Can't load th link");
          }
        }
    );
  }

  Widget bottomSheet() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text("Choose Photo (Max 2 MB)", style: TextStyle( fontSize: 20 ),),
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

  Widget popUp1(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if(value == "About"){
          showAlertDialog(context, about);
        }
        else if(value == "Report"){
          try{
            Map<String, String> body = {
              "pagename" : widget.pagename
            };
            var response = await networkHandler.patch("/page/report", body);
            if(response.statusCode == 200 || response.statusCode == 201) {
              showAlertDialog(context, "Done");
              fetchData1();
            }else{
              Map<String, dynamic> output = json.decode(response.body);
              showAlertDialog(context, output["msg"]);
            }
          }catch(e){
            showAlertDialog(context, "Some error occurred");
          }
        }
        else{
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(tagname: owner)));
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text("About"),
            value: "About",
          ),
          PopupMenuItem(
            child: Text("Owner"),
            value: "Owner",
          ),
          PopupMenuItem(
            child: Text("Report this page-  ${reports.length}"),
            value: "Report",
          ),
        ];
      },);
  }

  Widget popUp2(BuildContext context, String id, String writer, List<String> reports) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if(value == "Writer"){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(tagname: writer)));
        }else if(value == "Report"){
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
        }else{
          try{
            Map<String, String> body = {
              "id" : id,
              "pagename" : widget.pagename
            };
            var response = await networkHandler.post("/blog/delete/pa", body);
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
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Text("Writer"),
            value: "Writer",
          ),
          PopupMenuItem(
            child: Text("Report this post-  ${reports.length}"),
            value: "Report",
          ),
          PopupMenuItem(
            child: Text("Delete"),
            value: "Delete",
          ),
        ];
      },);
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