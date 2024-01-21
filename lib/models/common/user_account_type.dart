import 'package:json_annotation/json_annotation.dart';

part 'user_account_type.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAccountType {
  @JsonKey(name: '_id')
  String id;
  String type;
  bool status;

  UserAccountType(this.id, this.type, this.status);

  factory UserAccountType.fromJson(Map<String, dynamic> json) => _$UserAccountTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UserAccountTypeToJson(this);
}
