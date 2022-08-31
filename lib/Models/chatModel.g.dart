// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return ChatModel(
    by: json['by'] as String,
    subject: json['subject'] as String,
    postedAt: json['postedAt'] as String,
  );
}

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'by': instance.by,
      'subject': instance.subject,
      'postedAt': instance.postedAt,
    };
