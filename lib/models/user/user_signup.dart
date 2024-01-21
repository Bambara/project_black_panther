import 'package:json_annotation/json_annotation.dart';
import 'package:project_black_panther/models/common/address.dart';

import '../common/avatar.dart';
import '../common/contact.dart';
import '../common/play_frequency.dart';
import '../common/reminder_type.dart';
import '../common/user_account_type.dart';

part 'user_signup.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSignup {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  @JsonKey(name: 'user_name')
  String userName;

  String email;
  String mobile;

  @JsonKey(name: 'contact_info')
  Contact contactInfo;

  @JsonKey(name: 'address_info')
  Address addressInfo;

  String password;
  String role;

  @JsonKey(name: 'tfa_status')
  String tfaStatus;

  String status;

  Avatar avatar;

  @JsonKey(name: 'account_type')
  List<UserAccountType> accountType;

  @JsonKey(name: 'play_frequency')
  List<PlayFrequency> playFrequency;

  @JsonKey(name: 'reminder_type')
  List<ReminderType> reminderType;

  String createdAt;
  String updatedAt;
  @JsonKey(name: '__v')
  int v;

  UserSignup(this.id, this.firstName, this.lastName, this.userName, this.email, this.mobile, this.contactInfo, this.addressInfo, this.password, this.role, this.tfaStatus, this.status, this.avatar,
      this.accountType, this.playFrequency, this.reminderType, this.createdAt, this.updatedAt, this.v);

  factory UserSignup.fromJson(Map<String, dynamic> json) => _$UserSignupFromJson(json);

  Map<String, dynamic> toJson() => _$UserSignupToJson(this);
}
