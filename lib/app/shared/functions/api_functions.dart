import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';

ApiFuture<T> apiFunction<T>(
  Future<T> Function() func, {
  bool isDebug = false,
}) async {
  ApiFuture<T> actualFunc() async {
    final result = await func();
    return left(result);
  }

  if (isDebug) {
    return await actualFunc();
  }

  try {
    return actualFunc();
  } on FirebaseAuthException catch (e) {
    return right(FailureResponse(e.message ?? "An error occurred"));
  } on SocketException {
    return right(const InternetFailureResponse());
  } catch (e) {
    return right(OtherFailureResponse(e));
  }
}
