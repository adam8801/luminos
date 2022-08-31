import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Models/skillsModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class EditSkills extends StatefulWidget {
  @override
  _EditSkillsState createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {

  bool circular = true;
  bool language = false;
  bool developer = false;
  bool hardware = false;
  bool development = false;
  bool technologies = false;
  bool softSkill = false;
  NetworkHandler networkHandler = NetworkHandler();
  SkillModel skillModel = SkillModel();
  List<int> l = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  List<int> d = [0,0,0,0,0,0,0,0,0,0,0];
  List<int> h = [0,0,0,0];
  List<int> de = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
  List<int> t = [0,0,0,0,0,0,0,0,0];
  List<int> s = [0,0,0,0,0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      var response = await networkHandler.get("/skills/getData");
      if(response != null){
        setState(() {
          skillModel = SkillModel.fromJson(response["data"]);
          l[0] = skillModel.javaScript;
          l[1] = skillModel.c;
          l[2] = skillModel.cPlusPlus;
          l[3] = skillModel.python;
          l[4] = skillModel.php;
          l[5] = skillModel.html;
          l[6] = skillModel.css;
          l[7] = skillModel.java;
          l[8] = skillModel.cSharp;
          l[9] = skillModel.kotlin;
          l[10] = skillModel.sql;
          l[11] = skillModel.swift;
          l[12] = skillModel.go;
          l[13] = skillModel.pearl;
          l[14] = skillModel.vbDotNet;
          l[15] = skillModel.ruby;
          l[16] = skillModel.rust;
          l[17] = skillModel.matlab;
          l[18] = skillModel.r;
          l[19] = skillModel.noSql;
          l[20] = skillModel.assemblyLevelLanguage;
          d[0] = skillModel.frontend;
          d[1] = skillModel.backend;
          d[2] = skillModel.fullstack;
          d[3] = skillModel.mobile;
          d[4] = skillModel.web;
          d[5] = skillModel.embedded;
          d[6] = skillModel.software;
          d[7] = skillModel.dataScientist;
          d[8] = skillModel.devops;
          d[9] = skillModel.game;
          d[10] = skillModel.networkSecurity;
          h[0] = skillModel.verilog;
          h[1] = skillModel.fpga;
          h[2] = skillModel.engineeringDesign;
          h[3] = skillModel.boardDesign;
          de[0] = skillModel.nodeJs;
          de[1] = skillModel.django;
          de[2] = skillModel.angular;
          de[3] = skillModel.react;
          de[4] = skillModel.flutter;
          de[5] = skillModel.tensorFlow;
          de[6] = skillModel.android;
          de[7] = skillModel.spring;
          de[8] = skillModel.rubyOnRails;
          de[9] = skillModel.express;
          de[10] = skillModel.DotNetCore;
          de[11] = skillModel.vueDotjs;
          de[12] = skillModel.ember;
          de[13] = skillModel.xamarin;
          de[14] = skillModel.laravel;
          de[15] = skillModel.arduino;
          de[16] = skillModel.raspberryPi;
          de[17] = skillModel.linux;
          de[18] = skillModel.proteus;
          de[19] = skillModel.xilinx;
          de[20] = skillModel.labview;
          de[21] = skillModel.ltSpice;
          de[22] = skillModel.simulink;
          de[23] = skillModel.autoCad;
          de[24] = skillModel.solidWork;
          de[25] = skillModel.ansysFluent;
          de[26] = skillModel.microsoftProject;
          de[27] = skillModel.excel;
          de[28] = skillModel.sketchUp;
          de[29] = skillModel.autoCadCivil3d;
          de[30] = skillModel.chemcad;
          t[0] = skillModel.cyberSecurity;
          t[1] = skillModel.DL;
          t[2] = skillModel.ML;
          t[3] = skillModel.VrAr;
          t[4] = skillModel.blockchain;
          t[5] = skillModel.dataAnalytics;
          t[6] = skillModel.iot;
          t[7] = skillModel.robotics;
          t[8] = skillModel.aerospace;
          s[0] = skillModel.analyticalThinking;
          s[1] = skillModel.creativity;
          s[2] = skillModel.criticalThinking;
          s[3] = skillModel.communicationSkill;
          s[4] = skillModel.problemSolving;
          circular = false;
        });
      }
    }catch(e){
      showAlertDialog(context, "Some error occurred");
    }
  }

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
              decoration: boxDecoration(Colors.white, 40, Colors.black, 8, Colors.black),
              child: SingleChildScrollView(
                child: circular ? Center(child: CircularProgressIndicator()) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      alignment: Alignment.topLeft,
                      icon: Icon(Icons.arrow_back),
                    ),
                    Card(
                      elevation: 10,
                      color: Colors.blue[900],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text("Your Skills Set", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          language = !language;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Languages", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    language ? languages() : Container(),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          developer = !developer;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Developer", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    developer ? developers() : Container(),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          hardware = !hardware;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Hardware", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    hardware ? hardwares() : Container(),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          development = !development;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Development Tools", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    development ? developments() : Container(),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          technologies = !technologies;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Technology", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    technologies ? technology() : Container(),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          softSkill = !softSkill;
                        });
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.blue[900],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text("Soft Skills", style: TextStyle(fontSize: 15, color: Colors.white),),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    softSkill ? softSkills() : Container(),
                    SizedBox(height: 10,),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          try{
                            setState(() {
                              circular = true;
                              skillModel.javaScript = l[0];
                              skillModel.c = l[1];
                              skillModel.cPlusPlus = l[2];
                              skillModel.python = l[3];
                              skillModel.php = l[4];
                              skillModel.html = l[5];
                              skillModel.css = l[6];
                              skillModel.java = l[7];
                              skillModel.cSharp = l[8];
                              skillModel.kotlin = l[9];
                              skillModel.sql = l[10];
                              skillModel.swift = l[11];
                              skillModel.go = l[12];
                              skillModel.pearl = l[13];
                              skillModel.vbDotNet = l[14];
                              skillModel.ruby = l[15];
                              skillModel.rust = l[16];
                              skillModel.matlab = l[17];
                              skillModel.r = l[18];
                              skillModel.noSql = l[19];
                              skillModel.assemblyLevelLanguage = l[20];
                              skillModel.frontend = d[0];
                              skillModel.backend = d[1];
                              skillModel.fullstack = d[2];
                              skillModel.mobile = d[3];
                              skillModel.web = d[4];
                              skillModel.embedded = d[5];
                              skillModel.software = d[6];
                              skillModel.dataScientist = d[7];
                              skillModel.devops = d[8];
                              skillModel.game = d[9];
                              skillModel.networkSecurity = d[10];
                              skillModel.verilog = h[0];
                              skillModel.fpga = h[1];
                              skillModel.engineeringDesign = h[2];
                              skillModel.boardDesign = h[3];
                              skillModel.nodeJs = de[0];
                              skillModel.django = de[1];
                              skillModel.angular = de[2];
                              skillModel.react = de[3];
                              skillModel.flutter = de[4];
                              skillModel.tensorFlow = de[5];
                              skillModel.android = de[6];
                              skillModel.spring = de[7];
                              skillModel.rubyOnRails = de[8];
                              skillModel.express = de[9];
                              skillModel.DotNetCore = de[10];
                              skillModel.vueDotjs = de[11];
                              skillModel.ember = de[12];
                              skillModel.xamarin = de[13];
                              skillModel.laravel = de[14];
                              skillModel.arduino = de[15];
                              skillModel.raspberryPi = de[16];
                              skillModel.linux = de[17];
                              skillModel.proteus = de[18];
                              skillModel.xilinx = de[19];
                              skillModel.labview = de[20];
                              skillModel.ltSpice = de[21];
                              skillModel.simulink = de[22];
                              skillModel.autoCad = de[23];
                              skillModel.solidWork = de[24];
                              skillModel.ansysFluent = de[25];
                              skillModel.microsoftProject = de[26];
                              skillModel.excel = de[27];
                              skillModel.sketchUp = de[28];
                              skillModel.autoCadCivil3d = de[29];
                              skillModel.chemcad = de[30];
                              skillModel.cyberSecurity = t[0];
                              skillModel.DL = t[1];
                              skillModel.ML = t[2];
                              skillModel.VrAr = t[3];
                              skillModel.blockchain = t[4];
                              skillModel.dataAnalytics = t[5];
                              skillModel.iot = t[6];
                              skillModel.robotics = t[7];
                              skillModel.aerospace = t[8];
                              skillModel.analyticalThinking = s[0];
                              skillModel.creativity = s[1];
                              skillModel.criticalThinking = s[2];
                              skillModel.communicationSkill = s[3];
                              skillModel.problemSolving = s[4];
                            });
                            var response = await networkHandler.patchV("/skills/edit", skillModel.toJson());
                            if(response.statusCode == 200 || response.statusCode == 201){
                              Map<String, dynamic> output = json.decode(response.body);
                              showAlertDialog(context, output["msg"]);
                              setState(() {
                                circular = false;
                              });
                            }else{
                              Map<String, dynamic> output = json.decode(response.body);
                              showAlertDialog(context, output["msg"]);
                              setState(() {
                                circular = false;
                              });
                            }
                          }catch(e){
                            showAlertDialog(context, "Some error occurred");
                            setState(() {
                              circular = false;
                            });
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          color: Colors.teal,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Update", style: TextStyle(fontSize: 15, color: Colors.white),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Copyright © 2022 Jatin Gautam | All rights reserved",style: TextStyle(color: Colors.blue[900]),),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Email - lucero2a134@gmail.com",style: TextStyle(color: Colors.blue[900]),),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Twitter - www.twitter.com/Jatin2_99",style: TextStyle(color: Colors.blue[900]),),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("LinkedIn - www.linkedin.com/in/jatin-gautam2o99",style: TextStyle(color: Colors.blue[900]),),
                      ),
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }

  Widget languages () {
    return Column(
      children: [
        skillTileL("JavaScript", 0),
        skillTileL("C", 1),
        skillTileL("C++", 2),
        skillTileL("Python", 3),
        skillTileL("Php", 4),
        skillTileL("HTML", 5),
        skillTileL("CSS", 6),
        skillTileL("Java", 7),
        skillTileL("C#", 8),
        skillTileL("Kotlin", 9),
        skillTileL("SQL", 10),
        skillTileL("Swift", 11),
        skillTileL("Go", 12),
        skillTileL("Pearl", 13),
        skillTileL("VB.NET", 14),
        skillTileL("Ruby", 15),
        skillTileL("Rust", 16),
        skillTileL("Matlab", 17),
        skillTileL("R", 18),
        skillTileL("NoSQL", 19),
        skillTileL("Assembly Level Language", 20)
      ],
    );
  }

  Widget developers() {
    return Column(
      children: [
        skillTileD("Frontend", 0),
        skillTileD("Backend", 1),
        skillTileD("FullStack", 2),
        skillTileD("Mobile", 3),
        skillTileD("Web", 4),
        skillTileD("Embedded", 5),
        skillTileD("Software", 6),
        skillTileD("DataScientist", 7),
        skillTileD("DevOps", 8),
        skillTileD("Game", 9),
        skillTileD("Network Security", 10)
      ]
    );
  }

  Widget hardwares() {
    return Column(
      children: [
        skillTileH("Verilog", 0),
        skillTileH("FPGA", 1),
        skillTileH("Engineering Design", 2),
        skillTileH("Board Design", 3)
      ]
    );
  }

  Widget developments() {
    return Column(
      children: [
        skillTileDe("NodeJs", 0),
        skillTileDe("Django", 1),
        skillTileDe("Angular", 2),
        skillTileDe("React", 3),
        skillTileDe("Flutter", 4),
        skillTileDe("Tensor Flow", 5),
        skillTileDe("Android", 6),
        skillTileDe("Spring", 7),
        skillTileDe("Ruby on Rails", 8),
        skillTileDe("Express", 9),
        skillTileDe(".NetCore", 10),
        skillTileDe("Vue.Js", 11),
        skillTileDe("Ember", 12),
        skillTileDe("Xamarin", 13),
        skillTileDe("Laravel", 14),
        skillTileDe("Arduino", 15),
        skillTileDe("Raspberry Pi", 16),
        skillTileDe("Linux", 17),
        skillTileDe("Proteus", 18),
        skillTileDe("Xilinx", 19),
        skillTileDe("Labview", 20),
        skillTileDe("LtSpice", 21),
        skillTileDe("Simulink", 22),
        skillTileDe("AutoCad", 23),
        skillTileDe("SolidWork", 24),
        skillTileDe("Ansys Fluent", 25),
        skillTileDe("Microsoft Project", 26),
        skillTileDe("Excel", 27),
        skillTileDe("SketchUp", 28),
        skillTileDe("AutoCadCivil 3d", 29),
        skillTileDe("Chemcad", 30),
      ],
    );
  }

  Widget technology() {
    return Column(
      children: [
        skillTileT("CyberSecurity",0),
        skillTileT("Deep Learning",1),
        skillTileT("Machine Learning",2),
        skillTileT("VR & AR",3),
        skillTileT("Blockchain",4),
        skillTileT("Data Analytics",5),
        skillTileT("IOT",6),
        skillTileT("Robotics",7),
        skillTileT("Aerospace",8),
      ],
    );
  }

  Widget softSkills() {
    return Column(
      children: [
        skillTileS("Analytical Thinking", 0),
        skillTileS("Creartivity", 1),
        skillTileS("Critical Thinking", 2),
        skillTileS("Communication Skills", 3),
        skillTileS("Problem Thinking", 4)
      ],
    );
  }

  Widget skillTileL(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: l[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => l[i] = val.round()),
              label: l[i].toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget skillTileD(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: d[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => d[i] = val.round()),
              label: d[i].toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget skillTileH(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: h[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => h[i] = val.round()),
              label: h[i].toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget skillTileDe(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: de[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => de[i] = val.round()),
              label: de[i].toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget skillTileT(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: t[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => t[i] = val.round()),
              label: t[i].toString(),
            )
          ],
        ),
      ),
    );
  }

  Widget skillTileS(String label, int i) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.1),),
            Slider(
              value: s[i].toDouble(),
              min: 0,
              max: 10,
              divisions: 9,
              onChanged: (val) => setState(() => s[i] = val.round()),
              label: s[i].toString(),
            )
          ],
        ),
      ),
    );
  }

}
