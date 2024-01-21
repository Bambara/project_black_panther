// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['_id'] as String,
      (json['pay_amount'] as num).toDouble(),
      json['pay_methode'] as String,
      json['payer_type'] as String,
      json['payer_id'] as String,
      json['target_type'] as String,
      json['target_id'] as String,
      json['ref_number'] as String,
      (json['attachments'] as List<dynamic>).map((e) => ArtWork.fromJson(e as Map<String, dynamic>)).toList(),
      json['pay_reason'] as String,
      json['pay_reason_id'] as String,
      json['remark'] as String,
      json['trace'] as String,
      json['approve_status'] as String,
      json['createdAt'] as String,
      json['updatedAt'] as String,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      '_id': instance.id,
      'pay_amount': instance.payAmount,
      'pay_methode': instance.payMethode,
      'payer_type': instance.payerType,
      'payer_id': instance.payerId,
      'target_type': instance.targetType,
      'target_id': instance.targetId,
      'ref_number': instance.refNumber,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'pay_reason': instance.payReason,
      'pay_reason_id': instance.payReasonId,
      'remark': instance.remark,
      'trace': instance.trace,
      'approve_status': instance.approveStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
