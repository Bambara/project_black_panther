import 'package:json_annotation/json_annotation.dart';

import '../common/address.dart';
import '../common/avatar.dart';
import '../common/contact.dart';
import '../common/play_frequency.dart';
import '../common/reminder_type.dart';
import '../common/user_account_type.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
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

  Avatar avatar;

  @JsonKey(name: 'account_type')
  List<UserAccountType> accountType;

  @JsonKey(name: 'play_frequency')
  List<PlayFrequency> playFrequency;

  @JsonKey(name: 'reminder_type')
  List<ReminderType> reminderType;

  String status;

  String createdAt;
  String updatedAt;

  UserProfile(this.id, this.firstName, this.lastName, this.userName, this.email, this.mobile, this.contactInfo, this.addressInfo, this.password, this.role, this.tfaStatus, this.avatar,
      this.accountType, this.playFrequency, this.reminderType, this.status, this.createdAt, this.updatedAt);

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
