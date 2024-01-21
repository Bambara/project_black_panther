import 'package:json_annotation/json_annotation.dart';

part 'tt_group.g.dart';

@JsonSerializable(explicitToJson: true)
class TTGroup {
  @JsonKey(name: '_id')
  String id;

  String code;
  String name;
  String status;

  TTGroup(this.id, this.code, this.name, this.status);

  factory TTGroup.fromJson(Map<String, dynamic> json) => _$TTGroupFromJson(json);

  Map<String, dynamic> toJson() => _$TTGroupToJson(this);
}
