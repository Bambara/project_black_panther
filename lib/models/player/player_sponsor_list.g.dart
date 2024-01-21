// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_sponsor_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerSponsorList _$PlayerSponsorListFromJson(Map<String, dynamic> json) => PlayerSponsorList(
      json['_id'] as String,
      json['type'] as String,
      json['agreement_start_date'] as String,
      json['agreement_end_date'] as String,
      json['remark'] as String,
      json['status'] as String,
      json['sponsor_id'] as String,
    );

Map<String, dynamic> _$PlayerSponsorListToJson(PlayerSponsorList instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'agreement_start_date': instance.agreementStartDate,
      'agreement_end_date': instance.agreementEndDate,
      'remark': instance.remark,
      'status': instance.status,
      'sponsor_id': instance.sponsorId,
    };
