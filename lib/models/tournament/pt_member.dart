import 'package:json_annotation/json_annotation.dart';

part 'pt_member.g.dart';

//PTMember - PlayerTeamMember
@JsonSerializable(explicitToJson: true)
class PTMember {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'is_leader')
  bool isLeader;

  String remark;
  String status;

  @JsonKey(name: 'default_ign')
  String defaultIgn;

  @JsonKey(name: 'player_profile_id')
  String playerProfileId;

  PTMember(
    this.id,
    this.isLeader,
    this.remark,
    this.status,
    this.defaultIgn,
    this.playerProfileId,
  );

  factory PTMember.fromJson(Map<String, dynamic> json) => _$PTMemberFromJson(json);

  Map<String, dynamic> toJson() => _$PTMemberToJson(this);
}
