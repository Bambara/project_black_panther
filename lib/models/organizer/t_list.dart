import 'package:json_annotation/json_annotation.dart';

import 't_list_item.dart';

part 't_list.g.dart';

//Tournament List
@JsonSerializable(explicitToJson: true)
class TList {
  List<TListItem> tournaments;

  TList(this.tournaments);

  factory TList.fromJson(Map<String, dynamic> json) => _$TListFromJson(json);

  Map<String, dynamic> toJson() => _$TListToJson(this);
}
