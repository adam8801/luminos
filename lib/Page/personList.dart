import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/prListModel.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class PersonList extends StatefulWidget {

  final String label;
  final String pagename;
  final List<String> list;
  final int type;
  PersonList({this.label, this.list, this.type, this.pagename});
  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {

  bool circularState = true;
  NetworkHandler networkHandler = NetworkHandler();
  PrListModel profileList = PrListModel();
  List<ProfileModel> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      Map<String, dynamic> body ={
        "list" : widget.list
      };
      var response1 = await networkHandler.postRegister("/profile/customList", body);
      profileList = PrListModel.fromJson(json.decode(response1.body));
      setState(() {
        data = profileList.data;
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
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                              child: Center(child: Text(widget.label,style: TextStyle(fontSize: 20, color: Colors.white),)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          data.isNotEmpty ? Column(
                            children: data.map((link) => container(link.name, link.status ?? "", link.level, widget.type, link.tagname)).toList(),
                          ) : Container(),
                        ]
                    )
                )
            )
        )
    );
  }

  Widget container(String title, String subtitle, int auth, int type, String tagname) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[900], width: 2)
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(tagname: tagname))
              );
            },
              child: pageTile(title, subtitle, auth)
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              type == 1 ?
              InkWell(
                onTap: () async {
                  try{
                    Map<String, String> data = {
                      "tagname" : tagname,
                      "pagename" : widget.pagename
                    };
                    var response1 = await networkHandler.patchV("/page/removeAdmin", data);
                    if(response1.statusCode == 200 || response1.statusCode == 201){
                      showAlertDialog(context, "Done (To see changes press two times back after pressing ok.)");
                    }else{
                      showAlertDialog(context, "Operation failed");
                    }
                  }catch(e){
                    showAlertDialog(context, "Some error occurred");
                  }
                },
                  child: button("Remove as Admin")
              )
                  : type == 2 ?
              InkWell(
                onTap: () async {
                  try{
                    Map<String, String> data = {
                      "tagname" : tagname,
                      "pagename" : widget.pagename
                    };
                    var response1 = await networkHandler.patchV("/page/updateAdmin", data);
                    if(response1.statusCode == 200 || response1.statusCode == 201){
                      showAlertDialog(context, "Done (To see changes press two times back after pressing ok.)");
                    }else{
                      showAlertDialog(context, "Operation failed");
                    }
                  }catch(e){
                    showAlertDialog(context, "Some error occurred");
                  }
                },
                  child: button("Make an Admin")
              )
                  : Container(),
              SizedBox(width: 20,),
              type < 3 ?
              InkWell(
                onTap: () async {
                  try{
                    Map<String, String> data = {
                      "tagname" : tagname,
                      "pagename" : widget.pagename
                    };
                    var response1 = await networkHandler.patch("/page/removeByAdmin", data);
                    if(response1.statusCode == 200 || response1.statusCode == 201){
                      showAlertDialog(context, "Done (To see changes press two times back after pressing ok.)");
                    }else{
                      showAlertDialog(context, "Operation failed");
                    }
                  }catch(e){
                    showAlertDialog(context, "Some error occurred");
                  }
                },
                  child: button("Remove")
              )
                  :
              InkWell(
                onTap: () async {
                  try{
                    Map<String, String> data = {
                      "tagname" : tagname,
                      "pagename" : widget.pagename
                    };
                    var response1 = await networkHandler.patchV("/page/connect", data);
                    if(response1.statusCode == 200 || response1.statusCode == 201){
                      showAlertDialog(context, "Done (To see changes press two times back after pressing ok.)");
                    }else{
                      showAlertDialog(context, "Operation failed");
                    }
                  }catch(e){
                    showAlertDialog(context, "Some error occurred");
                  }
                },
                  child: button("Add as member")
              )
            ],
          )
        ],
      ),
    );
  }

  Widget pageTile(String title, String subtitle, int auth) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: boxDecoration(Colors.blue[500], 10, Colors.black, 2, Colors.black),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white),),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white),),
        //trailing: Text(members, style: TextStyle(color: Colors.white),),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: CircleAvatar(
            radius: 10,
            backgroundColor: auth > 0 ? auth == 2 ? Colors.blue[800] : Colors.teal : Colors.black,
            child: Icon(Icons.check, color: Colors.white, size: 25,),
          ),
        ),
      ),
    );
  }

  Widget button(String label) {
    return Card(
      elevation: 15,
      color: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(label)
        ),
      ),
    );
  }

}
