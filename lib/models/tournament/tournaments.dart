import 'package:json_annotation/json_annotation.dart';

import 'tournament.dart';

part 'tournaments.g.dart';

@JsonSerializable(explicitToJson: true)
class Tournaments {
  List<Tournament> tournaments;

  Tournaments(this.tournaments);

  factory Tournaments.fromJson(Map<String, dynamic> json) => _$TournamentsFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentsToJson(this);
}
