// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtWork _$ArtWorkFromJson(Map<String, dynamic> json) => ArtWork(
      json['_id'] as String,
      json['cloud_id'] as String,
      json['name'] as String,
      json['url'] as String,
    );

Map<String, dynamic> _$ArtWorkToJson(ArtWork instance) => <String, dynamic>{
      '_id': instance.id,
      'cloud_id': instance.cloudId,
      'name': instance.name,
      'url': instance.url,
    };
