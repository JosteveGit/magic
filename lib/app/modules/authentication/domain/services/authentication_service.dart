import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/modules/authentication/domain/services/interfaces/authentication_service_interface.dart';
import 'package:magic/app/shared/functions/api_functions.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:magic/app/shared/helpers/firebase/firebase_providers.dart';

final authenticationServiceProvider =
    Provider<AuthenticationServiceInterface>((ref) {
  final auth = ref.read(authProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthenticationService(auth: auth, firestore: firestore);
});

class AuthenticationService implements AuthenticationServiceInterface {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthenticationService({required this.auth, required this.firestore});
  @override
  ApiFuture<void> forgotPassword({required String email}) {
    return futureFunction(
      () async {
        await auth.sendPasswordResetEmail(email: email);
      },
    );
  }

  @override
  ApiFuture<UserModel> login({
    required String email,
    required String password,
  }) {
    return futureFunction(
      () async {
        final cred = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = cred.user!.uid;
        final user = await firestore.collection('users').doc(uid).get();
        return UserModel.fromMapAndUid(user.data()!, uid);
      },
    );
  }

  @override
  ApiFuture<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) {
    return futureFunction(
      () async {
        final creds = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final uid = creds.user!.uid;

        await firestore.collection('users').doc(creds.user!.uid).set({
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
        });
        return UserModel(
          email: email,
          firstName: firstName,
          lastName: lastName,
          uid: uid,
        );
      },
    );
  }
}
