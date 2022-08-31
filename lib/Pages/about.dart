import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String about = "Hello and welcome to all. Today we are so proud to introduce you to “Lucero”, something that will revolutionize the way we learn skills and share them with our people and we are so grateful that despite all of your busy schedules you all choose to witness this moment.\n\n “Lucero” is a place, a home of ideas, skills, friends, innovations and almost anything. It is a platform where knowledge is free and available to everyone, it is a place of creating communities and helping each other and growing it into something valuable for everyone’s future.\n\nAt “Lucero” we believe in the idea of sharing, the more we share the more we learn and thus we are devoted to provide you with all the tools needed to form these connections, to build a world where we all come together to solve problems that separate us from our dreams and to grow together.\n\nCome join us and be the change that you want to see in the world.";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: boxDecoration(Colors.blue[900], 40, Colors.black, 8, Colors.black),
      child: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              children: [
                Text(about, style: TextStyle(color: Colors.white,fontSize: 18),),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.white),),
                ),
              ],
            )
        ),
      ),
    );
  }
}
