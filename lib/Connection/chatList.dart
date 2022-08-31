import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_2/Connection/chat.dart';
import 'package:network_2/Models/chatsListModel.dart';
import 'package:network_2/Models/refChatModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  bool circularState = true;
  NetworkHandler networkHandler = NetworkHandler();
  List<RefChatModel> data = [];
  FlutterSecureStorage storage = FlutterSecureStorage();
  ChatsListModel chatsListModel = ChatsListModel();
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
      var response = await networkHandler.get("/profile/chatsList");
      chatsListModel = ChatsListModel.fromJson(response);
      setState(() {
        data = chatsListModel.data;
        circularState = false;
      });
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height-300,
        child: circularState ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          child: Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("\"Here only new messages will be visible.\nFor viewing old chats view them from chat feature\"",style: TextStyle(color: Colors.blue[900]),),
                ),
                SizedBox(height: 10,),
                data.isNotEmpty ? Column(
                  children: data.map(
                          (link) =>
                              InkWell(
                                onTap: () {
                                  if(tagname == link.holder1){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(tagname1: link.holder2, tagname2: tagname,)));
                                  }else{
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Chat(tagname1: link.holder1, tagname2: tagname,)));
                                  }
                                },
                                  child: pageTile(link.name1, link.name2)
                              ))
                      .toList(),
                ) : Center(child: Text("No recent chats"))
              ]
          ),
        )
    );
  }

  Widget pageTile(String name1, String name2) {
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
        title: Text("Members-\n $name1, $name2", style: TextStyle(color: Colors.white),),
      ),
    );
  }

}
