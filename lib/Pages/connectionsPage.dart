import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_2/Connection/all.dart';
import 'package:network_2/Connection/chatList.dart';
import 'package:network_2/Connection/connected.dart';
import 'package:network_2/Connection/requests.dart';

class ConnectionsPage extends StatefulWidget {
  @override
  _ConnectionsPageState createState() => _ConnectionsPageState();
}

class _ConnectionsPageState extends State<ConnectionsPage> {

  int index = 0;
  List<Widget> widgets = [
    AllConnectionList(),
    RequestsConnectionList(),
    ConnectedConnectionList(),
    ChatList()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.black,width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          tab(),
          widgets[index],
        ],
      ),
    );
  }

  Widget tab() {
    return Container(
      height: 50,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        color: Colors.white,
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: index == 0 ? Colors.blue[900] : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Text("People", style: TextStyle(color: index == 0 ? Colors.white : Colors.black, letterSpacing: 1.2),),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: index == 1 ? Colors.blue[800] : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Text("Requests", style: TextStyle(color: index == 1 ? Colors.white : Colors.black, letterSpacing: 1.2),),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: index == 2 ? Colors.blue[800] : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Text("Connected ", style: TextStyle(color: index == 2 ? Colors.white : Colors.black, letterSpacing: 1.2),),
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  color: index == 3 ? Colors.blue[800] : Colors.transparent,
                  onPressed: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Text("Recent Chats", style: TextStyle(color: index == 3 ? Colors.white : Colors.black, letterSpacing: 1.2),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
