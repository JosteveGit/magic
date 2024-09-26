import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:magic/app/modules/authentication/domain/services/interfaces/authentication_service_interface.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationServiceInterface extends Mock
    implements AuthenticationServiceInterface {}

void main() {
  group(
    "AuthenticationRepository",
    () {
      late AuthenticationServiceInterface service;
      late AuthenticationRepository repository;

      setUp(() {
        service = MockAuthenticationServiceInterface();
        repository = AuthenticationRepository(service: service);
      });

      test(
        "register() delegates to AuthenticationService and returns a UserModel",
        () async {
          when(
            () => service.register(
              email: "a@a.com",
              password: "password",
              firstName: "firstName",
              lastName: "lastName",
            ),
          ).thenAnswer(
            (_) async {
              return Left(
                UserModel(
                  firstName: "firstName",
                  lastName: "lastName",
                  email: "a@a.com",
                  uid: "uid",
                ),
              );
            },
          );

          final result = await repository.register(
            email: "a@a.com",
            password: "password",
            firstName: "firstName",
            lastName: "lastName",
          );

          expect(result, isA<Left<UserModel, FailureResponse>>());
        },
      );

      test(
        "register() delegates to AuthenticationService and throws an error.",
        () async {
          when(
            () => service.register(
              email: "a@a.com",
              password: "password",
              firstName: "firstName",
              lastName: "lastName",
            ),
          ).thenAnswer(
            (_) async {
              return const Right(FailureResponse("Something went wrong."));
            },
          );

          final result = await repository.register(
            email: "a@a.com",
            password: "password",
            firstName: "firstName",
            lastName: "lastName",
          );

          expect(result, isA<Right<UserModel, FailureResponse>>());
        },
      );

      test(
        "login() delegates to AuthenticationService and returns a UserModel",
        () async {
          when(
            () => service.login(
              email: "a@a.com",
              password: "password",
            ),
          ).thenAnswer(
            (_) async {
              return Left(
                UserModel(
                  firstName: "firstName",
                  lastName: "lastName",
                  email: "a@a.com",
                  uid: "uid",
                ),
              );
            },
          );

          final result = await repository.login(
            email: "a@a.com",
            password: "password",
          );

          expect(result, isA<Left<UserModel, FailureResponse>>());
        },
      );

      test(
        "login() delegates to AuthenticationService and throws an error.",
        () async {
          when(
            () => service.login(
              email: "a@a.com",
              password: "password",
            ),
          ).thenAnswer(
            (_) async {
              return const Right(
                FailureResponse("Something went wrong."),
              );
            },
          );

          final result = await repository.login(
            email: "a@a.com",
            password: "password",
          );

          expect(result, isA<Right<UserModel, FailureResponse>>());
        },
      );

      test(
        "forgotPassword() delegates to AuthenticationService",
        () async {
          when(
            () => service.forgotPassword(email: "a@a.com"),
          ).thenAnswer(
            (_) async {
              return const Left(null);
            },
          );

          final result = await repository.forgotPassword(email: "a@a.com");

          expect(result, isA<Left<void, FailureResponse>>());
        },
      );
    },
  );
}
