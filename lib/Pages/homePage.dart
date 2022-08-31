import 'dart:convert';

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
import 'package:network_2/networkHandler.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int val = 0;
  List<String> links = [];
  TextEditingController post = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  BlListModel blogList = BlListModel();
  BlListModel blogList1 = BlListModel();
  FlutterSecureStorage storage = FlutterSecureStorage();
  List<BlogModel> data = [];
  List<BlogModel> data1 = [];
  bool circularState = true;
  bool loadState = false;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  String tagname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      tagname = await storage.read(key: "tagname");
      Map<String, String> body = {
        "name" : "ok"
      };
      var response = await networkHandler.post("/blog/homeList/0", body);
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
          val = 0;
        });
      }
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  void fetchData1() async {
    try{
      setState(() {
        val = val + 10;
        loadState = true;
      });
      Map<String, String> body = {
        "name" : "ok"
      };
      var response = await networkHandler.post("/blog/homeList/${val.toString()}", body);
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
      backgroundColor: Colors.blue[900],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text("“Write something that you want to share to the world and to your people”",style: TextStyle(color: Colors.white),)
              ),
            ),
            SizedBox(height: 10,),
            writeSpace(),
            SizedBox(height: 10),
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    circularState = true;
                  });
                  fetchData();
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
            circularState ? Container() : data == [] || data == null ? Container() : blogs(),
            loadState ? CircularProgressIndicator() : moreTab("More"),
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
      )
    );
  }

  Widget blogs() {
    return Column(
      children: data.map((item) => blog(item.id, item.writer, item.reports, item.post, item.links, item.heart, item.like, item.share, DateTime.parse(item.dateTime).toLocal(), item.flag, item.commentNew)).toList(),
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
              popUp1(context, id, writer, reports),
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

  Widget writeSpace() {
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
                              child: addMultipleStrings(links: links, label: "Links",)
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
                          BlogModel blog = BlogModel(post: post.text, links: links, flag: _imageFile != null ? 1 : 0);
                          var response = await networkHandler.postBlog("/blog/add/pe", blog.toJson());
                          if(response.statusCode == 200 || response.statusCode == 201) {
                            if(_imageFile != null){
                              Map<String, dynamic> output = json.decode(response.body);
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
                            fetchData();
                            Map<String, dynamic> output = json.decode(response.body);
                            showAlertDialog(context, output["msg"]);
                          }else{
                            Map<String, dynamic> output = json.decode(response.body);
                            showAlertDialog(context, output["msg"]);
                          }
                        }else{
                          showAlertDialog(context, "Error");
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
            showAlertDialog(context, "Can't load the link");
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

  Widget popUp1(BuildContext context, String id, String writer, List<String> reports) {
    return PopupMenuButton<String>(
      onSelected: (value) async {
        if(value == "Writer"){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(tagname: writer)));
        }else{
          try{
            Map<String, String> body = {
              "blogId" : id
            };
            var response = await networkHandler.patch("/blog/report", body);
            if(response.statusCode == 200 || response.statusCode == 201) {
              showAlertDialog(context, "Done");
              fetchData();
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
            fetchData1();
          },
          child: Column(children: [Text(label), Icon(Icons.arrow_drop_down)],)
      ),
    );
  }

}
