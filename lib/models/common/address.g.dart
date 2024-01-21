// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['line_01'] as String,
      json['line_02'] as String,
      json['city'] as String,
      json['state'] as String,
      json['country'] as String,
      json['zip_code'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'line_01': instance.line_01,
      'line_02': instance.line_02,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zip_code': instance.zip_code,
    };
