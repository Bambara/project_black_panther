import 'package:json_annotation/json_annotation.dart';

import 'art_work.dart';

part 'sponsor_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class SponsorProfile {
  @JsonKey(name: '_id')
  String id;

  String name;

  @JsonKey(name: 'business_name')
  String businessName;

  @JsonKey(name: 'sponsor_type')
  String sponsorType;

  @JsonKey(name: 'art_works')
  List<ArtWork> artWorks;

  @JsonKey(name: 'ts_rate')
  dynamic tsRate;

  @JsonKey(name: 'ps_rate')
  dynamic psRate;

  String status;

  @JsonKey(name: 'user_id')
  String userId;

  String createdAt;
  String updatedAt;

  // @JsonKey(name: '__v')
  // int v;

  SponsorProfile(this.id, this.name, this.businessName, this.sponsorType, this.artWorks, this.tsRate, this.psRate, this.status, this.userId, this.createdAt, this.updatedAt);

  factory SponsorProfile.fromJson(Map<String, dynamic> json) => _$SponsorProfileFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorProfileToJson(this);
}
