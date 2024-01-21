import 'package:json_annotation/json_annotation.dart';

part 'player_sponsor_list.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerSponsorList {
  @JsonKey(name: '_id')
  String id;

  String type;

  @JsonKey(name: 'agreement_start_date')
  String agreementStartDate;

  @JsonKey(name: 'agreement_end_date')
  String agreementEndDate;

  String remark;

  String status;

  @JsonKey(name: 'sponsor_id')
  String sponsorId;

  PlayerSponsorList(this.id, this.type, this.agreementStartDate, this.agreementEndDate, this.remark, this.status, this.sponsorId);

  factory PlayerSponsorList.fromJson(Map<String, dynamic> json) => _$PlayerSponsorListFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerSponsorListToJson(this);
}
