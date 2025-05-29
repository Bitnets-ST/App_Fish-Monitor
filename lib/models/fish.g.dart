// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fish _$FishFromJson(Map<String, dynamic> json) => Fish(
      id: json['id'] as String,
      name: json['name'] as String,
      species: json['species'] as String,
      weight: (json['weight'] as num).toDouble(),
      length: (json['length'] as num).toDouble(),
      lastFeeding: DateTime.parse(json['lastFeeding'] as String),
      tankId: json['tankId'] as String,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$FishToJson(Fish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'species': instance.species,
      'weight': instance.weight,
      'length': instance.length,
      'lastFeeding': instance.lastFeeding.toIso8601String(),
      'tankId': instance.tankId,
      'notes': instance.notes,
    };
