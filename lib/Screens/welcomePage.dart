import 'package:flutter/material.dart';
import 'package:network_2/Pages/about.dart';
import 'package:network_2/Pages/signIn.dart';
import 'package:network_2/Pages/signUp.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          "Welcome to Lucero",
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "SignIn",),
            Tab(text: "SignUp",),
            Tab(text: "About",)
          ],
        ),
        elevation: 0,
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          SignIn(),
          SignUp(),
          AboutPage()
        ],
      ),
    );
  }
}
