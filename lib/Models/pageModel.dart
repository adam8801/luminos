import 'package:json_annotation/json_annotation.dart';

part 'pageModel.g.dart';

@JsonSerializable()
class PageModel{
  String pagename;
  String subtitle;
  String about;
  int level;
  String owner;
  List<String> admins;
  List<String> members;
  int privateKey;
  int allPost;
  List<String> rmembers;
  List<String> reports;

  PageModel({this.pagename, this.subtitle, this.about, this.level, this.owner, this.admins, this.members, this.privateKey, this.allPost, this.rmembers, this.reports});

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);
  Map<String, dynamic> toJson() => _$PageModelToJson(this);

}