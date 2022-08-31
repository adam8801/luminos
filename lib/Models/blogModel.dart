import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/commentModel.dart';

part 'blogModel.g.dart';

@JsonSerializable()
class BlogModel{

  String name;
  String post;
  int flag;
  int commentNew;
  String writer;
  @JsonKey(name: "_id")
  String id;
  List<String> like;
  List<String> heart;
  List<String> share;
  String dateTime;
  List<String> links;
  List<String> reports;
  List<CommentModel> comment;

  BlogModel({this.name, this.post, this.flag, this.commentNew, this.id, this.writer, this.heart, this.like, this.share, this.comment, this.dateTime, this.links, this.reports});

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);

}