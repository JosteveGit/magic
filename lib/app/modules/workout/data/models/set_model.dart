import 'package:equatable/equatable.dart';
import 'package:magic/app/shared/functions/string_functions.dart';

class SetModel extends Equatable {
  final SetType setType;
  final double weight;
  final int repetitions;

  const SetModel({
    required this.setType,
    required this.weight,
    required this.repetitions,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) {
    return SetModel(
      setType: SetType.fromString(json["setType"]),
      weight: json["weight"],
      repetitions: json["repetitions"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "setType": setType.name,
      "weight": weight,
      "repetitions": repetitions,
    };
  }

  String get typeName => capitalize(setType.cleanName);

  @override
  List<Object?> get props => [setType, weight, repetitions];
}

enum SetType {
  barbellRow,
  benchPress,
  shoulderPress,
  deadlift,
  squat;

  static SetType fromString(String value) {
    switch (value) {
      case "barbellRow":
        return SetType.barbellRow;
      case "benchPress":
        return SetType.benchPress;
      case "shoulderPress":
        return SetType.shoulderPress;
      case "deadlift":
        return SetType.deadlift;
      case "squat":
        return SetType.squat;
      default:
        throw Exception("Invalid value");
    }
  }

  String get cleanName {
    return name.replaceAll(RegExp(r"(?=[A-Z])"), " ");
  }
}
