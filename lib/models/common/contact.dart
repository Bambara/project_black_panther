import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable(explicitToJson: true)
class Contact {
  String mobile_number;
  String work_number;
  String fax_number;
  String email_address;
  String web_address;

  Contact(this.mobile_number, this.work_number, this.fax_number, this.email_address, this.web_address);

  factory Contact.fromJson(Map<String, dynamic> json) => _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
