import 'package:json_annotation/json_annotation.dart';

part 'chatModel.g.dart';

@JsonSerializable()
class ChatModel{

  String by;
  String subject;
  String postedAt;

  ChatModel({this.by, this.subject, this.postedAt});

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatModelToJson(this);

}