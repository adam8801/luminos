// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    privateKey: json['privateKey'] as int,
    achievements:
        (json['achievements'] as List)?.map((e) => e as String)?.toList(),
    work: (json['work'] as List)?.map((e) => e as String)?.toList(),
    level: json['level'] as int,
    hobbies: (json['hobbies'] as List)?.map((e) => e as String)?.toList(),
    about: json['about'] as String,
    education: (json['education'] as List)?.map((e) => e as String)?.toList(),
    projects: (json['projects'] as List)?.map((e) => e as String)?.toList(),
    pages: (json['pages'] as List)?.map((e) => e as String)?.toList(),
    rconnections:
        (json['rconnections'] as List)?.map((e) => e as String)?.toList(),
    connections:
        (json['connections'] as List)?.map((e) => e as String)?.toList(),
    freeze: json['freeze'] as int,
    tagname: json['tagname'] as String,
    name: json['name'] as String,
    status: json['status'] as String,
    gender: json['gender'] as int,
    currentDesignation: json['currentDesignation'] as String,
    location: json['location'] as String,
    dob: json['dob'] as String,
    email: json['email'] as String,
  )..created = (json['created'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'projects': instance.projects,
      'hobbies': instance.hobbies,
      'education': instance.education,
      'pages': instance.pages,
      'created': instance.created,
      'rconnections': instance.rconnections,
      'connections': instance.connections,
      'work': instance.work,
      'achievements': instance.achievements,
      'level': instance.level,
      'freeze': instance.freeze,
      'privateKey': instance.privateKey,
      'tagname': instance.tagname,
      'name': instance.name,
      'status': instance.status,
      'about': instance.about,
      'gender': instance.gender,
      'currentDesignation': instance.currentDesignation,
      'location': instance.location,
      'dob': instance.dob,
      'email': instance.email,
    };
