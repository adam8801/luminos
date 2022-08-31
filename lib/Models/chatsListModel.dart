import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/refChatModel.dart';

part 'chatsListModel.g.dart';

@JsonSerializable()
class ChatsListModel{
  List<RefChatModel> data;

  ChatsListModel({this.data});

  factory ChatsListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatsListModelToJson(this);

}