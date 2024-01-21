import 'package:json_annotation/json_annotation.dart';

part 'play_frequency.g.dart';

@JsonSerializable(explicitToJson: true)
class PlayFrequency {
  @JsonKey(name: '_id')
  String id;
  String type;
  String value;

  PlayFrequency(this.id, this.type, this.value);

  factory PlayFrequency.fromJson(Map<String, dynamic> json) => _$PlayFrequencyFromJson(json);

  Map<String, dynamic> toJson() => _$PlayFrequencyToJson(this);
}
