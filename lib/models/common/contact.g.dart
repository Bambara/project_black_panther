// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      json['mobile_number'] as String,
      json['work_number'] as String,
      json['fax_number'] as String,
      json['email_address'] as String,
      json['web_address'] as String,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'mobile_number': instance.mobile_number,
      'work_number': instance.work_number,
      'fax_number': instance.fax_number,
      'email_address': instance.email_address,
      'web_address': instance.web_address,
    };
