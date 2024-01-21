import 'package:json_annotation/json_annotation.dart';

part 'demo.g.dart';

@JsonSerializable(explicitToJson: true)
class Demo {
  String id;

  Demo(this.id);

  factory Demo.fromJson(Map<String, dynamic> json) => _$DemoFromJson(json);

  Map<String, dynamic> toJson() => _$DemoToJson(this);
}
