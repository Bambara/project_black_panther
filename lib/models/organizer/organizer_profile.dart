import 'package:json_annotation/json_annotation.dart';

import '../common/avatar.dart';
import '../common/organization.dart';

part 'organizer_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class OrganizerProfile {
  @JsonKey(name: '_id')
  String id;

  String name;
  String type;
  Avatar avatar;
  String status;

  @JsonKey(name: 'organization_id')
  String organizationId;

  @JsonKey(name: 'user_id')
  String userId;
  String createdAt;
  String updatedAt;
  List<Organization> organization;

  OrganizerProfile(this.id, this.name, this.type, this.avatar, this.status, this.organizationId, this.userId, this.createdAt, this.updatedAt, this.organization);

  factory OrganizerProfile.fromJson(Map<String, dynamic> json) => _$OrganizerProfileFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizerProfileToJson(this);
}
