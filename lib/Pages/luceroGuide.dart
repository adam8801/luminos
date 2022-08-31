import 'package:flutter/material.dart';
import 'package:network_2/customUi/decoration.dart';

class LuceroGuide extends StatelessWidget {

  String a = "We wanted to make the world better, more exciting and free for everyone and that means a world where nothing can stop us from achieving what we want if we have strong will power and work ethics for the things that we want. But the world can only change when the entities living inside it changes first and we are bringing this change. With “Lucero”, you define those changes.";
  String b = "Show the world what you are good at, teach those who need your skills, strengthened the human connections by creating communities and building them. Share your skills to learn more.";
  String c = "Now we like to share with you some tips that will help you and guide you here - ";
  String d = "•	“Lucero” always wants its nodes i.e. you to be healthy and secure and that’s why it has three types of authenticated user – Black ticked users (non verified users), Green ticked users (verified users), Blue ticked users (officially verified users). Initially the users are not verified but after some time we verify them.";
  String e = "•	Same analogy works in case of Pages.";
  String f = "•	Now creating pages is the moment where we bring the change in the world, we may define a problem that hasn’t been addressed yet or a solution that is different than the existing one or a tool that one can use to define something new in the world or just a place to share your views, ideas and information to everyone who wants to listen and much more.";
  String g = "•	 But creating pages also means creating places to rejoice with your people, to share entertainment or jokes to people around you, to motivate your friends, to debate on topics you like and to make a whole new universe.";
  String h = "• We uses only mail (the one which mailed you the otp at the time of sign up) system for contacting our users but you can also follow us on twitter (www.twitter.com/Jatin2_99) and LinkedIn (www.linkedin.com/in/jatin-gautam2o99) to get the latest updates and information";
  String i = "•	“Lucero” is the new way of interacting with strangers and making connections but one should know the boundaries of doing this. In the same sense, if any user has some problem with other user, she/he can write it in feedback page and keep the evidence for further investigation.";
  String j = "•	But the feedback page is not only for complains, we would love to hear from you about “Lucero” and what more we could do to make it more exciting, what features we could add or what rules we could append etc.";
  String k = "•	The current version of Lucero app does not support real time changes so we have provided a refresh button to load the content with new changes but when you move from one screen to another the content are already refreshed so you don’t need to press refresh button (think of it like web pages).";
  String l = "•	You will automatically be logout from our server 24hr after login so you have to login again else you will get errors";
  String m = "• You may get errors if you send too many requests to server. If that be the case please try after 30 minutes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Colors.blue[900],
      body: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: boxDecoration(Colors.blue[900], 40, Colors.black, 8, Colors.black),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        alignment: Alignment.topLeft,
                        icon: Icon(Icons.arrow_back, color: Colors.white,),
                      ),
                      Card(
                        elevation: 10,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Lucero's Guide", style: TextStyle(fontSize: 20, color: Colors.black),)),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(a,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(b,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(c,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(d,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(e,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(l,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(f,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(g,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(h,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(i,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(j,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(k,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Text(m,style: TextStyle(color: Colors.blue[900],fontSize: 15),)
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  )
              )
          )
      ),
    );
  }
}
