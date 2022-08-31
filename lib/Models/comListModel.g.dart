// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComListModel _$ComListModelFromJson(Map<String, dynamic> json) {
  return ComListModel(
    comment: (json['comment'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ComListModelToJson(ComListModel instance) =>
    <String, dynamic>{
      'comment': instance.comment,
    };
