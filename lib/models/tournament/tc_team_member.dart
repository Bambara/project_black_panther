import 'package:json_annotation/json_annotation.dart';

part 'tc_team_member.g.dart';

@JsonSerializable(explicitToJson: true)
class TCTeamMember {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'user_id')
  String userId;
  String role;
  String status;

  TCTeamMember(this.id, this.userId, this.role, this.status);

  factory TCTeamMember.fromJson(Map<String, dynamic> json) => _$TCTeamMemberFromJson(json);

  Map<String, dynamic> toJson() => _$TCTeamMemberToJson(this);
}
