// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) {
  return PageModel(
    pagename: json['pagename'] as String,
    subtitle: json['subtitle'] as String,
    about: json['about'] as String,
    level: json['level'] as int,
    owner: json['owner'] as String,
    admins: (json['admins'] as List)?.map((e) => e as String)?.toList(),
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
    privateKey: json['privateKey'] as int,
    allPost: json['allPost'] as int,
    rmembers: (json['rmembers'] as List)?.map((e) => e as String)?.toList(),
    reports: (json['reports'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
      'pagename': instance.pagename,
      'subtitle': instance.subtitle,
      'about': instance.about,
      'level': instance.level,
      'owner': instance.owner,
      'admins': instance.admins,
      'members': instance.members,
      'privateKey': instance.privateKey,
      'allPost': instance.allPost,
      'rmembers': instance.rmembers,
      'reports': instance.reports,
    };
