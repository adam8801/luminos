import 'package:flutter/material.dart';
import 'package:network_2/Page/all.dart';
import 'package:network_2/Page/connected.dart';
import 'package:network_2/Page/personal.dart';

class Pages extends StatefulWidget {
  @override
  _PagesState createState() => _PagesState();
}

class _PagesState extends State<Pages> {

  int index = 0;
  List<Widget> widgets = [
    AllPageList(),
    ConnectedPageList(),
    PersonalPageList()
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
                child: Text("All", style: TextStyle(color: index == 0 ? Colors.white : Colors.black,),),
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
                child: Text("Connected", style: TextStyle(color: index == 1 ? Colors.white : Colors.black,),),
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
                child: Text("Personal", style: TextStyle(color: index == 2 ? Colors.white : Colors.black,),),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
