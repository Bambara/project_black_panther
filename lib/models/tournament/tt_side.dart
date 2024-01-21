import 'package:json_annotation/json_annotation.dart';

part 'tt_side.g.dart';

@JsonSerializable(explicitToJson: true)
class TTSide {
  @JsonKey(name: '_id')
  String id;

  String side;
  String name;
  String status;

  TTSide(this.id, this.side, this.name, this.status);

  factory TTSide.fromJson(Map<String, dynamic> json) => _$TTSideFromJson(json);

  Map<String, dynamic> toJson() => _$TTSideToJson(this);
}
