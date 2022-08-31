// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrListModel _$PrListModelFromJson(Map<String, dynamic> json) {
  return PrListModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ProfileModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PrListModelToJson(PrListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
