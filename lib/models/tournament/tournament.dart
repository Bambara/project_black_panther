import 'package:json_annotation/json_annotation.dart';
import 'package:project_black_panther/models/common/art_work.dart';
import 'package:project_black_panther/models/tournament/t_fd.dart';
import 'package:project_black_panther/models/tournament/t_game.dart';
import 'package:project_black_panther/models/tournament/tt_side.dart';

import 'tc_team.dart';
import 'tournament_organizer.dart';
import 'tournament_sponsor.dart';
import 'tt_group.dart';

part 'tournament.g.dart';

@JsonSerializable(explicitToJson: true)
class Tournament {
  @JsonKey(name: '_id')
  String id;

  String name;

  @JsonKey(name: 'start_date')
  String startDate;

  @JsonKey(name: 'start_time')
  String startTime;

  @JsonKey(name: 'end_date')
  String endDate;

  @JsonKey(name: 'end_time')
  String endTime;

  @JsonKey(name: 'reg_open_date')
  String regOpenDate;

  @JsonKey(name: 'reg_open_time')
  String regOpenTime;

  @JsonKey(name: 'reg_close_date')
  String regCloseDate;

  @JsonKey(name: 'reg_close_time')
  String regCloseTime;

  @JsonKey(name: 'art_works')
  List<ArtWork> artWorks;

  String type;

  @JsonKey(name: 'participant_type')
  String participantType;

  String status;

  @JsonKey(name: 'to_list')
  List<TournamentOrganizer> toList;

  @JsonKey(name: 'ts_list')
  List<TournamentSponsor> tsList;

  @JsonKey(name: 'tct_list')
  List<TCTeam> tctList;

  @JsonKey(name: 'team_groups')
  List<TTGroup> teamGroups;

  @JsonKey(name: 'team_sides')
  List<TTSide> teamSides;

  @JsonKey(name: 'tg_list')
  List<TGame> tgList;

  @JsonKey(name: 'finance_details')
  List<TFinanceDetails> financeDetails;

  String createdAt;
  String updatedAt;

  Tournament(
    this.id,
    this.name,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.regOpenDate,
    this.regOpenTime,
    this.regCloseDate,
    this.regCloseTime,
    this.artWorks,
    this.type,
    this.participantType,
    this.status,
    this.toList,
    this.tsList,
    this.tctList,
    this.teamGroups,
    this.teamSides,
    this.tgList,
    this.financeDetails,
    this.createdAt,
    this.updatedAt,
  );

  factory Tournament.fromJson(Map<String, dynamic> json) => _$TournamentFromJson(json);

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}
