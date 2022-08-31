// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatListModel _$ChatListModelFromJson(Map<String, dynamic> json) {
  return ChatListModel(
    chats: (json['chats'] as List)
        ?.map((e) =>
            e == null ? null : ChatModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatListModelToJson(ChatListModel instance) =>
    <String, dynamic>{
      'chats': instance.chats,
    };
