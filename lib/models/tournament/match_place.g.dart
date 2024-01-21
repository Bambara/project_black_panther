// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchPlace _$MatchPlaceFromJson(Map<String, dynamic> json) => MatchPlace(
      json['address'] as String,
      Location.fromJson(json['gps_location'] as Map<String, dynamic>),
      (json['images'] as List<dynamic>).map((e) => ArtWork.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$MatchPlaceToJson(MatchPlace instance) => <String, dynamic>{
      'address': instance.address,
      'gps_location': instance.gpsLocation.toJson(),
      'images': instance.images.map((e) => e.toJson()).toList(),
    };
