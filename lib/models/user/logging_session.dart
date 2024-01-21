import 'package:json_annotation/json_annotation.dart';

part 'logging_session.g.dart';

@JsonSerializable()
class LoggingSession {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  String email;

  @JsonKey(name: 'user_name')
  String userName;
  String role;
  String token;

  LoggingSession(this.id, this.firstName, this.lastName, this.email, this.userName, this.role, this.token);

  factory LoggingSession.fromJson(Map<String, dynamic> json) => _$LoggingSessionFromJson(json);

  Map<String, dynamic> toJson() => _$LoggingSessionToJson(this);
}
