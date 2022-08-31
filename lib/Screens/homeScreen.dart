import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:network_2/Connection/editProfile.dart';
import 'package:network_2/Pages/connectionsPage.dart';
import 'package:network_2/Pages/editSkills.dart';
import 'package:network_2/Pages/feedback.dart';
import 'package:network_2/Pages/homePage.dart';
import 'package:network_2/Pages/luceroGuide.dart';
import 'package:network_2/Pages/pages.dart';
import 'package:network_2/Connection/profile.dart';
import 'package:network_2/Screens/welcomeScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;
  int freeze;
  List<Widget> widgets = [
    HomePage(),
    ConnectionsPage(),
    Pages(),
    ProfilePage()
  ];
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    freeze = int.parse(await storage.read(key: "freeze"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(40),
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
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            drawer: Container(
              width: MediaQuery.of(context).size.width-80,
              child: Drawer(
                 child: Padding(
                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                   child: Column(
                    children: [
                      freeze == 0 ? Card(
                        elevation: 15,
                        color: Colors.blue[500],
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditSkills() ));
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text("Edit Skills", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                            ],
                          ),
                        ),
                      ) : Container(),
                      Card(
                        elevation: 15,
                        color: Colors.blue[500],
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LuceroGuide() ));
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text("Lucero's Guide", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 15,
                        color: Colors.blue[500],
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile() ));
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text("Edit Profile", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 15,
                        color: Colors.blue[500],
                        child: FlatButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FeedBack()));
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text("Feedback", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 15,
                        color: Colors.blue[500],
                        child: FlatButton(
                          onPressed: () async {
                            await storage.delete(key: "tagname");
                            await storage.delete(key: "token");
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                    (route) => false
                            );
                          },
                          child: Row(
                            children: [
                              Expanded(child: Text("Log Out", textAlign: TextAlign.center, style: TextStyle(fontSize: 18),)),
                            ],
                          ),
                        ),
                      ),
                    ],
                ),
                 ),
              ),
            ),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              title: Text("Lucero", style: TextStyle(letterSpacing: 2),),
              centerTitle: true,
            ),
            body: widgets[index],
            bottomNavigationBar: Container(
              height: 70,
              child: Card(
                color: Colors.blue[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FlatButton.icon(
                        color: index == 0 ? Colors.white : Colors.transparent,
                          onPressed: (){
                            setState(() {
                              index = 0;
                            });
                          },
                          icon: Icon(Icons.home_filled, color: index == 0 ? Colors.blueAccent : Colors.white,),
                          label: Text("Home", style: TextStyle(color: index == 0 ? Colors.blueAccent : Colors.white,),)
                      ),
                      Icon(Icons.circle, size: 7, color: Colors.white),
                      FlatButton.icon(
                          color: index == 1 ? Colors.white : Colors.transparent,
                          onPressed: (){
                            setState(() {
                              index = 1;
                            });
                          },
                          icon: Icon(Icons.people_rounded, color: index == 1 ? Colors.blueAccent : Colors.white,),
                          label: Text("Connections", style: TextStyle(color: index == 1 ? Colors.blueAccent : Colors.white,),)
                      ),
                      Icon(Icons.circle, size: 7, color: Colors.white),
                      FlatButton.icon(
                          color: index == 2 ? Colors.white : Colors.transparent,
                          onPressed: (){
                            setState(() {
                              index = 2;
                            });
                          },
                          icon: Icon(Icons.pages_sharp, color: index == 2 ? Colors.blueAccent : Colors.white,),
                          label: Text("Pages", style: TextStyle(color: index == 2 ? Colors.blueAccent : Colors.white,),)
                      ),
                      Icon(Icons.circle, size: 7, color: Colors.white),
                      FlatButton.icon(
                          color: index == 3 ? Colors.white : Colors.transparent,
                          onPressed: (){
                            setState(() {
                              index = 3;
                            });
                          },
                          icon: Icon(Icons.account_box_rounded, color: index == 3 ? Colors.blueAccent : Colors.white,),
                          label: Text("Profile", style: TextStyle(color: index == 3 ? Colors.blueAccent : Colors.white,),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}