// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Club _$ClubFromJson(Map<String, dynamic> json) => Club(
      name: json['name'] as String,
      country: json['country'] as String,
      value: json['value'] as int,
      image: json['image'] as String,
      european_titles: json['european_titles'] as int,
    );

Map<String, dynamic> _$ClubToJson(Club instance) => <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'value': instance.value,
      'image': instance.image,
      'european_titles': instance.european_titles,
    };
