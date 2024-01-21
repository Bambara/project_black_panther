import 'package:json_annotation/json_annotation.dart';

import 'avatar.dart';
import 'organization_member.dart';

part 'organization.g.dart';

@JsonSerializable(explicitToJson: true)
class Organization {
  @JsonKey(name: '_id')
  String id;

  String name;
  Avatar logo;
  String type;
  String status;
  List<OrganizationMember> members;
  String createdAt;
  String updatedAt;

  // @JsonKey(name: '__v')
  // int v;

  Organization(this.id, this.name, this.logo, this.type, this.status, this.members, this.createdAt, this.updatedAt);

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
