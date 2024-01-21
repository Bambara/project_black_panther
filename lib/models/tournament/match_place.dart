import 'package:json_annotation/json_annotation.dart';

import '../common/art_work.dart';
import '../common/location.dart';

part 'match_place.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchPlace {
  // @JsonKey(name: '_id')
  // String id;

  String address;

  @JsonKey(name: 'gps_location')
  Location gpsLocation;

  List<ArtWork> images;

  MatchPlace(this.address, this.gpsLocation, this.images);

  factory MatchPlace.fromJson(Map<String, dynamic> json) => _$MatchPlaceFromJson(json);

  Map<String, dynamic> toJson() => _$MatchPlaceToJson(this);
}
