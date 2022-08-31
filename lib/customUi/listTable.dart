import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/paListModel.dart';
import 'package:network_2/Models/pageModel.dart';
import 'package:network_2/Models/prListModel.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/Page/page.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class ListTable extends StatefulWidget {

  final String label;
  final List<dynamic> list;
  final int type;
  ListTable({this.label, this.list, this.type});

  @override
  _ListTableState createState() => _ListTableState();
}

class _ListTableState extends State<ListTable> {

  bool circularState = true;
  NetworkHandler networkHandler = NetworkHandler();
  PrListModel profileList = PrListModel();
  PaListModel pageList = PaListModel();
  List<ProfileModel> data = [];
  List<PageModel> data1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    Map<String, dynamic> body ={
      "list" : widget.list
    };
    if(widget.type == 1){
      var response1 = await networkHandler.postRegister("/profile/customList", body);
      if(response1.statusCode == 200 || response1.statusCode == 201){
        profileList = PrListModel.fromJson(json.decode(response1.body));
        setState(() {
          data = profileList.data;
          circularState = false;
        });
      }
      else{
        showAlertDialog(context, "error");
      }
    }else{
      var response1 = await networkHandler.postRegister("/page/customList", body);
      if(response1.statusCode == 200 || response1.statusCode == 201){
        pageList = PaListModel.fromJson(json.decode(response1.body));
        setState(() {
          data1 = pageList.data;
          circularState = false;
        });
      }
      else{
        showAlertDialog(context, "error");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return widget.type == 1 ? Scaffold(
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
                  child: circularState ? Center(child: CircularProgressIndicator(),) : Column(
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
                          child: Center(child: Text(widget.label, style: TextStyle(fontSize: 20, color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      data.isNotEmpty ? Column(
                        children: data.map((link) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ProfilePage(tagname: link.tagname))
                            );
                          },
                            child: pageTile(link.name, link.status ?? "", link.level)
                        )).toList(),
                      ) : Container(),
                    ]
                  )
                )
              )
            )
    ) : Scaffold(
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
                    child: circularState ? Center(child: CircularProgressIndicator(),) : Column(
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
                              child: Center(child: Text(widget.label, style: TextStyle(fontSize: 20, color: Colors.white),)),
                            ),
                          ),
                          SizedBox(height: 10,),
                          data1.isNotEmpty ? Column(
                            children: data1.map((item) => InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualPage(pagename: item.pagename, subtitle: item.subtitle, members: item.members)));
                              },
                                child: pageTile1(item.pagename, item.subtitle, item.members != [] ? item.members.length.toString() : "0" , item.level)
                            )).toList(),
                          ) : Container(),
                          SizedBox(height: 10),
                        ]
                    )
                )
            )
        )
    );
  }

  Widget pageTile1(String title, String subtitle, String members, int auth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blue[500],
        borderRadius: BorderRadius.circular(10),
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
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white),),
        subtitle: Text(subtitle+"\n\n"+"Members- "+members, style: TextStyle(color: Colors.white),),
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

  Widget pageTile(String title, String members, int auth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: boxDecoration(Colors.blue[500], 10, Colors.black, 2, Colors.black),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.white),),
        subtitle: Text(members, style: TextStyle(color: Colors.white),),
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
}
