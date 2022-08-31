import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_2/Models/skillsModel.dart';
import 'package:network_2/customUi/decoration.dart';
import 'package:network_2/networkHandler.dart';

class ShowSkills extends StatefulWidget {

  final String tagname;
  final String name;
  final bool others;
  ShowSkills({this.tagname, this.name, this.others});

  @override
  _ShowSkillsState createState() => _ShowSkillsState();
}

class _ShowSkillsState extends State<ShowSkills> {

  NetworkHandler networkHandler = NetworkHandler();
  SkillModel skillModel = SkillModel();
  bool circularState = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try{
      if(widget.others == false){
        var response = await networkHandler.get("/skills/getData");
        if(response != null){
          setState(() {
            skillModel = SkillModel.fromJson(response["data"]);
            circularState = false;
          });
        }
      }else{
        Map<String, String> body ={
          "tagname" : widget.tagname
        };
        var response = await networkHandler.post("/skills/getOthersData", body);
        if(response.statusCode == 200 || response.statusCode == 201){
          setState(() {
            skillModel = SkillModel.fromJson((json.decode(response.body))["data"]);
            circularState = false;
          });
        }else{
          showAlertDialog(context, "Error");
        }
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
                child: circularState ? Center(child: CircularProgressIndicator()) : Column(
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
                        child: Center(child: Text("${widget.name} Skills Set", style: TextStyle(fontSize: 20, color: Colors.white),)),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.javaScript != 0 ? tile("JavaScript",skillModel.javaScript) : Container(),
                    skillModel.c != 0 ? tile("C",skillModel.c) : Container(),
                    skillModel.cPlusPlus != 0 ? tile("C++",skillModel.cPlusPlus) : Container(),
                    skillModel.python != 0 ? tile("Python",skillModel.python) : Container(),
                    skillModel.php != 0 ? tile("Php",skillModel.php) : Container(),
                    skillModel.html != 0 ? tile("HTML",skillModel.html) : Container(),
                    skillModel.css != 0 ? tile("CSS",skillModel.css) : Container(),
                    skillModel.java != 0 ? tile("Java",skillModel.java) : Container(),
                    skillModel.cSharp != 0 ? tile("C#",skillModel.cSharp) : Container(),
                    skillModel.kotlin != 0 ? tile("Kotlin",skillModel.kotlin) : Container(),
                    skillModel.sql != 0 ? tile("SQL",skillModel.sql) : Container(),
                    skillModel.swift != 0 ? tile("Swift",skillModel.swift) : Container(),
                    skillModel.go != 0 ? tile("Go",skillModel.go) : Container(),
                    skillModel.pearl != 0 ? tile("Pearl",skillModel.pearl) : Container(),
                    skillModel.vbDotNet != 0 ? tile("VB.Net",skillModel.vbDotNet) : Container(),
                    skillModel.ruby != 0 ? tile("Ruby",skillModel.ruby) : Container(),
                    skillModel.rust != 0 ? tile("Rust",skillModel.rust) : Container(),
                    skillModel.matlab != 0 ? tile("MATLAB",skillModel.matlab) : Container(),
                    skillModel.r != 0 ? tile("R",skillModel.r) : Container(),
                    skillModel.noSql != 0 ? tile("NoSQL",skillModel.noSql) : Container(),
                    skillModel.assemblyLevelLanguage != 0 ? tile("Assembly Level Language",skillModel.assemblyLevelLanguage) : Container(),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.frontend != 0 ? tile("Frontend",skillModel.frontend) : Container(),
                    skillModel.backend != 0 ? tile("Backend",skillModel.backend) : Container(),
                    skillModel.fullstack != 0 ? tile("FullStack",skillModel.fullstack) : Container(),
                    skillModel.mobile != 0 ? tile("Mobile",skillModel.mobile) : Container(),
                    skillModel.web != 0 ? tile("Web",skillModel.web) : Container(),
                    skillModel.embedded != 0 ? tile("Embedded",skillModel.embedded) : Container(),
                    skillModel.software != 0 ? tile("Software",skillModel.software) : Container(),
                    skillModel.dataScientist != 0 ? tile("Data Scientist",skillModel.dataScientist) : Container(),
                    skillModel.devops != 0 ? tile("DevOps",skillModel.devops) : Container(),
                    skillModel.game != 0 ? tile("Game",skillModel.game) : Container(),
                    skillModel.networkSecurity != 0 ? tile("Network Security",skillModel.networkSecurity) : Container(),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.verilog != 0 ? tile("Verilog",skillModel.verilog) : Container(),
                    skillModel.fpga != 0 ? tile("FPGA",skillModel.fpga) : Container(),
                    skillModel.engineeringDesign != 0 ? tile("Engineering Design",skillModel.engineeringDesign) : Container(),
                    skillModel.boardDesign != 0 ? tile("Board Design",skillModel.boardDesign) : Container(),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.nodeJs != 0 ? tile("NodeJs",skillModel.nodeJs) : Container(),
                    skillModel.django != 0 ? tile("Django",skillModel.django) : Container(),
                    skillModel.angular != 0 ? tile("Angular",skillModel.angular) : Container(),
                    skillModel.react != 0 ? tile("React",skillModel.react) : Container(),
                    skillModel.flutter != 0 ? tile("Flutter",skillModel.flutter) : Container(),
                    skillModel.tensorFlow != 0 ? tile("Tensor Flow",skillModel.tensorFlow) : Container(),
                    skillModel.android != 0 ? tile("Android",skillModel.android) : Container(),
                    skillModel.spring != 0 ? tile("Spring",skillModel.spring) : Container(),
                    skillModel.rubyOnRails != 0 ? tile("RubyOnRails",skillModel.rubyOnRails) : Container(),
                    skillModel.express != 0 ? tile("Express",skillModel.express) : Container(),
                    skillModel.DotNetCore != 0 ? tile(".NetCore",skillModel.DotNetCore) : Container(),
                    skillModel.vueDotjs != 0 ? tile("Vue.Js",skillModel.vueDotjs) : Container(),
                    skillModel.ember != 0 ? tile("Ember",skillModel.ember) : Container(),
                    skillModel.xamarin != 0 ? tile("Xamarin",skillModel.xamarin) : Container(),
                    skillModel.laravel != 0 ? tile("Larvel",skillModel.laravel) : Container(),
                    skillModel.arduino != 0 ? tile("Arduino",skillModel.arduino) : Container(),
                    skillModel.raspberryPi != 0 ? tile("Raspberry Pi",skillModel.raspberryPi) : Container(),
                    skillModel.linux != 0 ? tile("Linux",skillModel.linux) : Container(),
                    skillModel.proteus != 0 ? tile("Proteus",skillModel.proteus) : Container(),
                    skillModel.xilinx != 0 ? tile("Xilinx",skillModel.xilinx) : Container(),
                    skillModel.labview != 0 ? tile("Labview",skillModel.labview) : Container(),
                    skillModel.ltSpice != 0 ? tile("LTspice",skillModel.ltSpice) : Container(),
                    skillModel.simulink != 0 ? tile("Simulink",skillModel.simulink) : Container(),
                    skillModel.autoCad != 0 ? tile("AutoCad",skillModel.autoCad) : Container(),
                    skillModel.solidWork != 0 ? tile("SolidWork",skillModel.solidWork) : Container(),
                    skillModel.ansysFluent != 0 ? tile("ANSYS Fluent",skillModel.ansysFluent) : Container(),
                    skillModel.microsoftProject != 0 ? tile("Microsoft Project",skillModel.microsoftProject) : Container(),
                    skillModel.excel != 0 ? tile("Excel",skillModel.excel) : Container(),
                    skillModel.sketchUp != 0 ? tile("SketchUp",skillModel.sketchUp) : Container(),
                    skillModel.autoCadCivil3d != 0 ? tile("AutoCadCivil3d",skillModel.autoCadCivil3d) : Container(),
                    skillModel.chemcad != 0 ? tile("Chemcad",skillModel.chemcad) : Container(),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.cyberSecurity != 0 ? tile("CyberSecurity",skillModel.cyberSecurity) : Container(),
                    skillModel.DL != 0 ? tile("Deep Learning",skillModel.DL) : Container(),
                    skillModel.ML != 0 ? tile("Machine Learning",skillModel.ML) : Container(),
                    skillModel.VrAr != 0 ? tile("VR & AR",skillModel.VrAr) : Container(),
                    skillModel.blockchain != 0 ? tile("Blockchain",skillModel.blockchain) : Container(),
                    skillModel.dataAnalytics != 0 ? tile("Data Analytics",skillModel.dataAnalytics) : Container(),
                    skillModel.iot != 0 ? tile("IOT",skillModel.iot) : Container(),
                    skillModel.robotics != 0 ? tile("Robotics",skillModel.robotics) : Container(),
                    skillModel.aerospace != 0 ? tile("Aerospace",skillModel.aerospace) : Container(),
                    SizedBox(height: 10,),
                    Card(
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
                    SizedBox(height: 10,),
                    skillModel.analyticalThinking != 0 ? tile("Analytical Thinking",skillModel.analyticalThinking) : Container(),
                    skillModel.creativity != 0 ? tile("Creativity",skillModel.creativity) : Container(),
                    skillModel.criticalThinking != 0 ? tile("Critical Thinking",skillModel.criticalThinking) : Container(),
                    skillModel.communicationSkill != 0 ? tile("Communication Skills",skillModel.communicationSkill) : Container(),
                    skillModel.problemSolving != 0 ? tile("Problem Solving",skillModel.problemSolving) : Container(),
                    SizedBox(height: 10,),
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

  Widget tile(String label, int num) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue[700],width: 2)
      ),
      child: Center(child: Text("$label - $num/10",style: TextStyle(fontWeight: FontWeight.bold),)),
    );
  }

}
