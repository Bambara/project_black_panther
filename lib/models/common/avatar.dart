import 'package:json_annotation/json_annotation.dart';

part 'avatar.g.dart';

@JsonSerializable(explicitToJson: true)
class Avatar {
  @JsonKey(name: 'cloud_id')
  String cloudId;
  String name;
  String url;

  Avatar(this.cloudId, this.name, this.url);

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
