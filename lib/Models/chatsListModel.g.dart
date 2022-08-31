// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatsListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatsListModel _$ChatsListModelFromJson(Map<String, dynamic> json) {
  return ChatsListModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : RefChatModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChatsListModelToJson(ChatsListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
