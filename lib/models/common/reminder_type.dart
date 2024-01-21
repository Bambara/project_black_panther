import 'package:json_annotation/json_annotation.dart';

part 'reminder_type.g.dart';

@JsonSerializable(explicitToJson: true)
class ReminderType {
  @JsonKey(name: '_id')
  String id;
  String type;
  bool status;

  ReminderType(this.id, this.type, this.status);

  factory ReminderType.fromJson(Map<String, dynamic> json) => _$ReminderTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderTypeToJson(this);
}
