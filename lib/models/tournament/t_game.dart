import 'package:json_annotation/json_annotation.dart';

part 't_game.g.dart';

@JsonSerializable(explicitToJson: true)
class TGame {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'game_id')
  String gameId;

  String status;

  TGame(this.id, this.gameId, this.status);

  factory TGame.fromJson(Map<String, dynamic> json) => _$TGameFromJson(json);

  Map<String, dynamic> toJson() => _$TGameToJson(this);
}
