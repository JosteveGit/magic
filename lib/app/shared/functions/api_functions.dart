import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';

ApiFuture<T> futureFunction<T>(
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
    return await actualFunc();
  } on FirebaseAuthException catch (e) {
    if (e.code == "invalid-credential") {
      return right(const FailureResponse("Invalid credentials"));
    }

    return right(FailureResponse(e.message ?? "An error occurred"));
  } on SocketException {
    return right(const InternetFailureResponse());
  } catch (e) {
    return right(OtherFailureResponse(e));
  }
}

ApiStream<T> streamFunction<T>(
  Stream<T> Function() func, {
  bool isDebug = false,
}) {
  ApiStream<T> actualFunc() {
    final result = func();
    return result.map((e) => left(e));
  }

  if (isDebug) {
    return actualFunc();
  }

  try {
    return actualFunc();
  } on FirebaseAuthException catch (e) {
    if (e.code == "invalid-credential") {
      return Stream.value(right(const FailureResponse("Invalid credentials")));
    }

    return Stream.value(
      right(
        FailureResponse(e.message ?? "An error occurred"),
      ),
    );
  } on SocketException {
    return Stream.value(right(const InternetFailureResponse()));
  } catch (e) {
    return Stream.value(right(OtherFailureResponse(e)));
  }
}
