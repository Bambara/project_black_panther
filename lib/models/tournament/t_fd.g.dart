// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_fd.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TFinanceDetails _$TFinanceDetailsFromJson(Map<String, dynamic> json) => TFinanceDetails(
      json['_id'] as String,
      json['type'] as String,
      json['bank'] as String,
      json['branch'] as String,
      json['account_number'] as String,
      json['account_holder'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TFinanceDetailsToJson(TFinanceDetails instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'bank': instance.bank,
      'branch': instance.branch,
      'account_number': instance.accountNumber,
      'account_holder': instance.accountHolder,
      'status': instance.status,
    };
