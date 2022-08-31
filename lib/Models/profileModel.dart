import 'package:json_annotation/json_annotation.dart';

part 'profileModel.g.dart';

@JsonSerializable()
class ProfileModel{
  List<String> projects;
  List<String> hobbies;
  List<String> education;
  List<String> pages;
  List<String> created;
  List<String> rconnections;
  List<String> connections;
  List<String> work;
  List<String> achievements;
  int level;
  int freeze;
  int privateKey;
  String tagname;
  String name;
  String status;
  String about;
  int gender;
  String currentDesignation;
  String location;
  String dob;
  String email;

  ProfileModel({this.privateKey, this.achievements, this.work, this.level, this.hobbies, this.about, this.education, this.projects, this.pages, this.rconnections, this.connections, this.freeze, this.tagname, this.name, this.status, this.gender, this.currentDesignation, this.location, this.dob, this.email});

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

}