import 'package:json_annotation/json_annotation.dart';

part 'tournament_sponsor.g.dart';

@JsonSerializable(explicitToJson: true)
class TournamentSponsor {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'sponsor_id')
  String sponsorId;

  String type;
  String coverage;
  String status;

  TournamentSponsor(this.id, this.sponsorId, this.type, this.coverage, this.status);

  factory TournamentSponsor.fromJson(Map<String, dynamic> json) => _$TournamentSponsorFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentSponsorToJson(this);
}
