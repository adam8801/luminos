import 'package:json_annotation/json_annotation.dart';

part 'refChatModel.g.dart';

@JsonSerializable()
class RefChatModel{

  String holder1;
  String holder2;
  String name1;
  String name2;

  RefChatModel({this.holder1, this.holder2, this.name1, this.name2});

  factory RefChatModel.fromJson(Map<String, dynamic> json) =>
      _$RefChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$RefChatModelToJson(this);

}