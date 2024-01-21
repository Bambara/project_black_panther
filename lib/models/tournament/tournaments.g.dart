// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournaments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournaments _$TournamentsFromJson(Map<String, dynamic> json) => Tournaments(
      (json['tournaments'] as List<dynamic>).map((e) => Tournament.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TournamentsToJson(Tournaments instance) => <String, dynamic>{
      'tournaments': instance.tournaments.map((e) => e.toJson()).toList(),
    };
