import 'package:json_annotation/json_annotation.dart';
import 'package:network_2/Models/chatModel.dart';

part 'chatListModel.g.dart';

@JsonSerializable()
class ChatListModel{
  List<ChatModel> chats;

  ChatListModel({this.chats});

  factory ChatListModel.fromJson(Map<String, dynamic> json) =>
      _$ChatListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatListModelToJson(this);

}