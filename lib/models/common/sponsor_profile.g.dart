// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsorProfile _$SponsorProfileFromJson(Map<String, dynamic> json) => SponsorProfile(
      json['_id'] as String,
      json['name'] as String,
      json['business_name'] as String,
      json['sponsor_type'] as String,
      (json['art_works'] as List<dynamic>).map((e) => ArtWork.fromJson(e as Map<String, dynamic>)).toList(),
      json['ts_rate'],
      json['ps_rate'],
      json['status'] as String,
      json['user_id'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$SponsorProfileToJson(SponsorProfile instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'business_name': instance.businessName,
      'sponsor_type': instance.sponsorType,
      'art_works': instance.artWorks.map((e) => e.toJson()).toList(),
      'ts_rate': instance.tsRate,
      'ps_rate': instance.psRate,
      'status': instance.status,
      'user_id': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
