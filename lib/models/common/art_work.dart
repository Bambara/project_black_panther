import 'package:json_annotation/json_annotation.dart';

part 'art_work.g.dart';

@JsonSerializable(explicitToJson: true)
class ArtWork {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'cloud_id')
  String cloudId;

  String name;
  String url;

  ArtWork(this.id, this.cloudId, this.name, this.url);

  factory ArtWork.fromJson(Map<String, dynamic> json) => _$ArtWorkFromJson(json);

  Map<String, dynamic> toJson() => _$ArtWorkToJson(this);
}
