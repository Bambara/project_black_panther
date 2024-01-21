import 'package:json_annotation/json_annotation.dart';

part 'organization_member.g.dart';

@JsonSerializable(explicitToJson: true)
class OrganizationMember {
  @JsonKey(name: '_id')
  String id;

  String level;

  @JsonKey(name: 'member_id')
  String memberId;

  String status;

  OrganizationMember(this.id, this.level, this.memberId, this.status);

  factory OrganizationMember.fromJson(Map<String, dynamic> json) => _$OrganizationMemberFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationMemberToJson(this);
}
