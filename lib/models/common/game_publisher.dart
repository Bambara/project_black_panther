import 'package:json_annotation/json_annotation.dart';

part 'game_publisher.g.dart';

@JsonSerializable(explicitToJson: true)
class GamePublisher {
  String id;
  String name;

  GamePublisher(this.id, this.name);

  factory GamePublisher.fromJson(Map<String, dynamic> json) => _$GamePublisherFromJson(json);

  Map<String, dynamic> toJson() => _$GamePublisherToJson(this);
}
