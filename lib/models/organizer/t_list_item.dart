import 'package:json_annotation/json_annotation.dart';

import '../common/organization.dart';
import '../common/sponsor_profile.dart';
import '../tournament/tournament.dart';

part 't_list_item.g.dart';

//Tournament List Item
@JsonSerializable(explicitToJson: true)
class TListItem {
  Tournament tournament;
  List<Organization> organizers;
  List<SponsorProfile> sponsors;

  TListItem(this.tournament, this.organizers, this.sponsors);

  factory TListItem.fromJson(Map<String, dynamic> json) => _$TListItemFromJson(json);

  Map<String, dynamic> toJson() => _$TListItemToJson(this);
}
