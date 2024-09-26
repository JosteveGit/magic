import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';

class UserModel extends Cachable {
  final String firstName;
  final String lastName;
  final String email;
  final String uid;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromMapAndUid(Map<String, dynamic> map, String uid) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      uid: uid,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      uid: map['uid'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'uid': uid,
    };
  }
}
