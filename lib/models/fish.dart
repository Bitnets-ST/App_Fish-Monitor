import 'package:json_annotation/json_annotation.dart';

part 'fish.g.dart';

@JsonSerializable()
class Fish {
  final String id;
  final String name;
  final String species;
  final double weight;
  final double length;
  final DateTime lastFeeding;
  final String tankId;
  final String notes;

  Fish({
    required this.id,
    required this.name,
    required this.species,
    required this.weight,
    required this.length,
    required this.lastFeeding,
    required this.tankId,
    this.notes = '',
  });

  factory Fish.fromJson(Map<String, dynamic> json) => _$FishFromJson(json);
  Map<String, dynamic> toJson() => _$FishToJson(this);
} 