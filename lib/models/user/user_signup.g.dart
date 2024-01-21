// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_signup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignup _$UserSignupFromJson(Map<String, dynamic> json) => UserSignup(
      json['_id'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['user_name'] as String,
      json['email'] as String,
      json['mobile'] as String,
      Contact.fromJson(json['contact_info'] as Map<String, dynamic>),
      Address.fromJson(json['address_info'] as Map<String, dynamic>),
      json['password'] as String,
      json['role'] as String,
      json['tfa_status'] as String,
      json['status'] as String,
      Avatar.fromJson(json['avatar'] as Map<String, dynamic>),
      (json['account_type'] as List<dynamic>).map((e) => UserAccountType.fromJson(e as Map<String, dynamic>)).toList(),
      (json['play_frequency'] as List<dynamic>).map((e) => PlayFrequency.fromJson(e as Map<String, dynamic>)).toList(),
      (json['reminder_type'] as List<dynamic>).map((e) => ReminderType.fromJson(e as Map<String, dynamic>)).toList(),
      json['createdAt'] as String,
      json['updatedAt'] as String,
      json['__v'] as int,
    );

Map<String, dynamic> _$UserSignupToJson(UserSignup instance) => <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'user_name': instance.userName,
      'email': instance.email,
      'mobile': instance.mobile,
      'contact_info': instance.contactInfo.toJson(),
      'address_info': instance.addressInfo.toJson(),
      'password': instance.password,
      'role': instance.role,
      'tfa_status': instance.tfaStatus,
      'status': instance.status,
      'avatar': instance.avatar.toJson(),
      'account_type': instance.accountType.map((e) => e.toJson()).toList(),
      'play_frequency': instance.playFrequency.map((e) => e.toJson()).toList(),
      'reminder_type': instance.reminderType.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
