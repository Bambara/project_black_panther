import 'package:json_annotation/json_annotation.dart';

part 'generic_login.g.dart';

@JsonSerializable(explicitToJson: true)
class GenericLogin {
  @JsonKey(name: 'user_name')
  String userName;
  String password;

  GenericLogin(this.userName, this.password);

  factory GenericLogin.fromJson(Map<String, dynamic> json) => _$GenericLoginFromJson(json);

  Map<String, dynamic> toJson() => _$GenericLoginToJson(this);
}
