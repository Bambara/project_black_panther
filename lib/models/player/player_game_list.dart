import 'package:json_annotation/json_annotation.dart';

import '../common/play_frequency.dart';
import 'player_performance_result.dart';

part 'player_game_list.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayerGameList {
  @JsonKey(name: '_id')
  String id;

  String ign;

  @JsonKey(name: 'play_frequency')
  List<PlayFrequency> playFrequency;

  // @JsonKey(name: 'play_frq_type')
  // String playFrqType;
  //
  // @JsonKey(name: 'play_frq_time')
  // String playFrqTime;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'performance_result')
  PlayerPerformanceResult performanceResult;

  PlayerGameList(this.id, this.ign, this.playFrequency, this.gameId, this.performanceResult);

  factory PlayerGameList.fromJson(Map<String, dynamic> json) => _$PlayerGameListFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerGameListToJson(this);
}
