// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TList _$TListFromJson(Map<String, dynamic> json) => TList(
      (json['tournaments'] as List<dynamic>).map((e) => TListItem.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$TListToJson(TList instance) => <String, dynamic>{
      'tournaments': instance.tournaments.map((e) => e.toJson()).toList(),
    };
