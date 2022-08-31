import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/prListModel.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class ConnectedConnectionList extends StatefulWidget {
  @override
  _ConnectedConnectionListState createState() => _ConnectedConnectionListState();
}

class _ConnectedConnectionListState extends State<ConnectedConnectionList> {

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
      var response = await networkHandler.get("/profile/getConnections");
      Map<String, dynamic> body ={
        "list" : response["data"]["connections"]
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
    return Column(
      children: [
        circularState ? CircularProgressIndicator() : Container(
          height: MediaQuery.of(context).size.height-290,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: data != [] ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(tagname: data[index].tagname))
                  );
                },
                child: pageTile(data[index].name, data[index].status ?? "" , data[index].level)
            ),
          ) : Container(),
        )
      ],
    );
  }

  Widget pageTile(String title, String members, int auth) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
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
