import 'package:json_annotation/json_annotation.dart';

import 'avatar.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  @JsonKey(name: '_id')
  String id;

  String name;

  Avatar poster;

  @JsonKey(name: 'age_category')
  String ageCategory;

  @JsonKey(name: 'publisher_id')
  String publisherId;

  @JsonKey(name: 'play_type')
  String playType;

  @JsonKey(name: 'player_type')
  String playerType;

  String status;
  String createdAt;
  String updatedAt;

  Game(this.id, this.name, this.poster, this.ageCategory, this.publisherId, this.playType, this.playerType, this.status, this.createdAt, this.updatedAt);

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  Map<String, dynamic> toJson() => _$GameToJson(this);
}
