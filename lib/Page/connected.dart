import 'package:flutter/material.dart';
import 'package:network_2/Models/paListModel.dart';
import 'package:network_2/Models/pageModel.dart';
import 'package:network_2/Page/page.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class ConnectedPageList extends StatefulWidget {
  @override
  _ConnectedPageListState createState() => _ConnectedPageListState();
}

class _ConnectedPageListState extends State<ConnectedPageList> {

  int val = 0;
  bool circularState = true;
  bool loadState = false;
  NetworkHandler networkHandler = NetworkHandler();
  PaListModel pageList = PaListModel();
  PaListModel pageList1 = PaListModel();
  List<PageModel> data = [];
  List<PageModel> data1 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      var response = await networkHandler.get("/page/connectedList/0");
      pageList = PaListModel.fromJson(response);
      setState(() {
        data = pageList.data;
        circularState = false;
        val = 0;
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
      var response = await networkHandler.get("/page/connectedList/${val.toString()}");
      pageList1 = PaListModel.fromJson(response);
      if(pageList1.data.isNotEmpty){
        setState(() {
          data1 = pageList1.data;
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
    return circularState ? CircularProgressIndicator() : Container(
      height: MediaQuery.of(context).size.height-300,
      padding: EdgeInsets.symmetric(vertical: 5),
      child:
      data != [] ?
      SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: data.map((item) => InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IndividualPage(pagename: item.pagename, subtitle: item.subtitle, members: item.members)));
                },
                  child: pageTile(item.pagename, item.subtitle, item.members != [] ? item.members.length.toString() : "0" , item.level)
              )).toList(),
            ),
            loadState ? CircularProgressIndicator() : moreTab("More"),
          ],
        ),
      ) : Container(),
    );
  }

  Widget pageTile(String title, String subtitle, String members, int auth) {
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
