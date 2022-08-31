// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    by: json['by'] as String,
    from: json['from'] as String,
    subject: json['subject'] as String,
    postedAt: json['postedAt'] as String,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'by': instance.by,
      'from': instance.from,
      'subject': instance.subject,
      'postedAt': instance.postedAt,
    };
