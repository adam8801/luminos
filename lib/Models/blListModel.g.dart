// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlListModel _$BlListModelFromJson(Map<String, dynamic> json) {
  return BlListModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BlogModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BlListModelToJson(BlListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
