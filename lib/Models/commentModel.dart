import 'package:json_annotation/json_annotation.dart';

part 'commentModel.g.dart';

@JsonSerializable()
class CommentModel{
  String by;
  String from;
  String subject;
  String postedAt;

  CommentModel({this.by, this.from, this.subject, this.postedAt});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

}