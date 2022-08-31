import 'package:json_annotation/json_annotation.dart';

part 'skillsModel.g.dart';

@JsonSerializable()
class SkillModel{

  String tagname;
  int javaScript;
  int swift;
  int go;
  int python;
  int ruby;
  int rust;
  int c;
  int cPlusPlus;
  int cSharp;
  int kotlin;
  int php;
  int matlab;
  int r;
  int sql;
  int html;
  int css;
  int vbDotNet;
  int assemblyLevelLanguage;
  int java;
  int noSql;
  int pearl;
  int frontend;
  int backend;
  int fullstack;
  int mobile;
  int game;
  int embedded;
  int dataScientist;
  int devops;
  int software;
  int web;
  int networkSecurity;
  int verilog;
  int fpga;
  int engineeringDesign;
  int boardDesign;
  int rubyOnRails;
  int django;
  int angular;
  int laravel;
  int express;
  int react;
  int nodeJs;
  int vueDotjs;
  int ember;
  int xamarin;
  int flutter;
  int android;
  int spring;
  int DotNetCore;
  int tensorFlow;
  int analyticalThinking;
  int creativity;
  int criticalThinking;
  int communicationSkill;
  int problemSolving;
  int cyberSecurity;
  int DL;
  int ML;
  int VrAr;
  int blockchain;
  int dataAnalytics;
  int iot;
  int robotics;
  int aerospace;
  int arduino;
  int raspberryPi;
  int linux;
  int proteus;
  int xilinx;
  int labview;
  int ltSpice;
  int simulink;
  int autoCad;
  int solidWork;
  int ansysFluent;
  int microsoftProject;
  int excel;
  int sketchUp;
  int autoCadCivil3d;
  int chemcad;

  SkillModel({
    this.tagname ,this.javaScript ,this.swift ,this.go ,this.python, this.ruby, this.rust, this.c, this.cPlusPlus,
    this.cSharp, this.kotlin, this.php, this.matlab, this.r, this.sql, this.html, this.css, this.vbDotNet, this.assemblyLevelLanguage,
    this.java, this.noSql, this.pearl, this.frontend, this.backend, this.fullstack, this.mobile, this.game, this.embedded, this.dataScientist,
    this.devops, this.software, this.web, this.networkSecurity, this.verilog, this.fpga, this.engineeringDesign, this.boardDesign,
    this.rubyOnRails, this.django, this.angular, this.laravel, this.express, this.react, this.nodeJs, this.vueDotjs, this.ember,
    this.xamarin, this.flutter, this.android, this.spring, this.DotNetCore, this.tensorFlow, this.analyticalThinking, this.creativity,
    this.criticalThinking, this.communicationSkill, this.problemSolving, this.cyberSecurity, this.DL, this.ML, this.VrAr, this.blockchain,
    this.dataAnalytics, this.iot, this.robotics, this.aerospace, this.arduino, this.raspberryPi, this.linux, this.proteus, this.xilinx,
    this.labview, this.ltSpice, this.simulink, this.autoCad, this.solidWork, this.ansysFluent, this.microsoftProject, this.excel, this.sketchUp,
    this.autoCadCivil3d, this.chemcad
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) =>
      _$SkillModelFromJson(json);
  Map<String, dynamic> toJson() => _$SkillModelToJson(this);

}