import 'package:json_annotation/json_annotation.dart';

import 'art_work.dart';

part 'payment.g.dart';

@JsonSerializable(explicitToJson: true)
class Payment {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'pay_amount')
  double payAmount;

  @JsonKey(name: 'pay_methode')
  String payMethode;

  @JsonKey(name: 'payer_type')
  String payerType;

  @JsonKey(name: 'payer_id')
  String payerId;

  @JsonKey(name: 'target_type')
  String targetType;

  @JsonKey(name: 'target_id')
  String targetId;

  @JsonKey(name: 'ref_number')
  String refNumber;

  List<ArtWork> attachments;

  @JsonKey(name: 'pay_reason')
  String payReason;

  @JsonKey(name: 'pay_reason_id')
  String payReasonId;

  String remark;

  String trace;

  @JsonKey(name: 'approve_status')
  String approveStatus;

  String createdAt;
  String updatedAt;

  Payment(
    this.id,
    this.payAmount,
    this.payMethode,
    this.payerType,
    this.payerId,
    this.targetType,
    this.targetId,
    this.refNumber,
    this.attachments,
    this.payReason,
    this.payReasonId,
    this.remark,
    this.trace,
    this.approveStatus,
    this.createdAt,
    this.updatedAt,
  );

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
