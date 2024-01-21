import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address {
  String line_01;
  String line_02;
  String city;
  String state;
  String country;
  String zip_code;

  Address(this.line_01, this.line_02, this.city, this.state, this.country, this.zip_code);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
