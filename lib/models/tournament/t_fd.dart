import 'package:json_annotation/json_annotation.dart';

part 't_fd.g.dart';

@JsonSerializable(explicitToJson: true)
class TFinanceDetails {
  @JsonKey(name: '_id')
  String id;

  String type;

  String bank;
  String branch;

  @JsonKey(name: 'account_number')
  String accountNumber;

  @JsonKey(name: 'account_holder')
  String accountHolder;

  String status;

  TFinanceDetails(this.id, this.type, this.bank, this.branch, this.accountNumber, this.accountHolder, this.status);

  factory TFinanceDetails.fromJson(Map<String, dynamic> json) => _$TFinanceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TFinanceDetailsToJson(this);
}
