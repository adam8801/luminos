import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_2/Connection/profile1.dart';
import 'package:network_2/Models/prListModel.dart';
import 'package:network_2/Models/profileModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class AllConnectionList extends StatefulWidget {
  @override
  _AllConnectionListState createState() => _AllConnectionListState();
}

class _AllConnectionListState extends State<AllConnectionList> {

  int val = 0;
  bool circularState = true;
  bool loadState = false;
  NetworkHandler networkHandler = NetworkHandler();
  FlutterSecureStorage storage = FlutterSecureStorage();
  PrListModel profileList = PrListModel();
  PrListModel profileList1 = PrListModel();
  List<ProfileModel> data = [];
  List<ProfileModel> data1 = [];
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
      var response = await networkHandler.get("/profile/list/0");
      profileList = PrListModel.fromJson(response);
      setState(() {
        data = profileList.data;
        circularState = false;
      });
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  void fetchData1() async {
    try{
      setState(() {
        val = val + 5;
        loadState = true;
      });
      var response = await networkHandler.get("/profile/list/${val.toString()}");
      profileList1 = PrListModel.fromJson(response);
      if(profileList1.data.isNotEmpty){
        setState(() {
          data1 = profileList1.data;
          data = data + data1;
          loadState = false;
        });
      }else{
        setState(() {
          loadState = false;
        });
        showAlertDialog(context, "You have reached to the bottom");
      }
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        circularState ? CircularProgressIndicator() : Container(
          height: MediaQuery.of(context).size.height-331,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: data != [] ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => data[index].tagname != tagname ? InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(tagname: data[index].tagname))
                  );
                },
                child: pageTile(data[index].name, data[index].status ?? "" , data[index].level)
            ) : Container(),
          ) : Container(),
        ),
        loadState ? CircularProgressIndicator() : moreTab("More"),
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
