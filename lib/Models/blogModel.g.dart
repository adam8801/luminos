// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) {
  return BlogModel(
    name: json['name'] as String,
    post: json['post'] as String,
    flag: json['flag'] as int,
    commentNew: json['commentNew'] as int,
    id: json['_id'] as String,
    writer: json['writer'] as String,
    heart: (json['heart'] as List)?.map((e) => e as String)?.toList(),
    like: (json['like'] as List)?.map((e) => e as String)?.toList(),
    share: (json['share'] as List)?.map((e) => e as String)?.toList(),
    comment: (json['comment'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dateTime: json['dateTime'] as String,
    links: (json['links'] as List)?.map((e) => e as String)?.toList(),
    reports: (json['reports'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
      'name': instance.name,
      'post': instance.post,
      'flag': instance.flag,
      'commentNew': instance.commentNew,
      'writer': instance.writer,
      '_id': instance.id,
      'like': instance.like,
      'heart': instance.heart,
      'share': instance.share,
      'dateTime': instance.dateTime,
      'links': instance.links,
      'reports': instance.reports,
      'comment': instance.comment,
    };
