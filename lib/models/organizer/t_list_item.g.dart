// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TListItem _$TListItemFromJson(Map<String, dynamic> json) => TListItem(
      Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
      (json['organizers'] as List<dynamic>).map((e) => Organization.fromJson(e as Map<String, dynamic>)).toList(),
      (json['sponsors'] as List<dynamic>).map((e) => SponsorProfile.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TListItemToJson(TListItem instance) => <String, dynamic>{
      'tournament': instance.tournament.toJson(),
      'organizers': instance.organizers.map((e) => e.toJson()).toList(),
      'sponsors': instance.sponsors.map((e) => e.toJson()).toList(),
    };
