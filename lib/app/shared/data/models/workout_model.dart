import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';

class WorkoutModel {
  final List<SetModel> sets;
  final String id;
  final Timestamp date;

  WorkoutModel({
    required this.sets,
    required this.id,
    required this.date,
  });

  factory WorkoutModel.fromJsonAndId(Map<String, dynamic> json, String id) {
    return WorkoutModel(
      sets: (json['sets'] as List).map((e) => SetModel.fromJson(e)).toList(),
      id: id,
      date: (json['created_at'] as Timestamp),
    );
  }
}
