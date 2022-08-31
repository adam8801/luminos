// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaListModel _$PaListModelFromJson(Map<String, dynamic> json) {
  return PaListModel(
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PaListModelToJson(PaListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
