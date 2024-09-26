import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic/app/modules/workout/data/models/set_model.dart';
import 'package:magic/app/shared/functions/date_functions.dart';

class WorkoutModel {
  final List<SetModel> sets;
  final String id;
  final Timestamp date;

  int get totalReps {
    return sets.fold(
        0, (previousValue, element) => previousValue + element.repetitions);
  }

  int get totalSets => sets.length;

  String get formattedDate {
    return formatDate(date.toDate());
  }

  List<SetType> get types {
    return sets.map((e) => e.setType).toSet().toList();
  }

  WorkoutModel({
    required this.sets,
    required this.id,
    required this.date,
  });

  factory WorkoutModel.fromJsonAndId(Map<String, dynamic> json, String id) {
    return WorkoutModel(
      sets: (json['sets'] as List).map((e) => SetModel.fromJson(e)).toList(),
      id: id,
      date: json['created_at'] == null
          ? Timestamp.now()
          : (json['created_at'] as Timestamp),
    );
  }
}
