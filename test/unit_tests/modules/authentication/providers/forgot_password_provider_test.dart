import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/forgot_password/forgot_password_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/forgot_password/forgot_password_state.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepositoryInterface {}

void main() {
  group(
    'ForgotPasswordNotifier',
    () {
      late AuthenticationRepositoryInterface repository;
      late ForgotPasswordNotifier forgotPasswordNotifier;

      setUp(() {
        repository = MockAuthenticationRepository();
        forgotPasswordNotifier = ForgotPasswordNotifier(repo: repository);
      });

      test(
        'successful forgotPassword updates state to ForgotPasswordState.success',
        () async {
          when(() => repository.forgotPassword(email: any(named: 'email')))
              .thenAnswer(
            (_) async => left(null),
          );

          expectLater(
            forgotPasswordNotifier.stream,
            emitsInOrder([
              const ForgotPasswordState.loading(),
              const ForgotPasswordState.success(),
            ]),
          );

          forgotPasswordNotifier.forgotPassword(email: 'test@example.com');
        },
      );

      test(
        'forgotPassword failure updates state to ForgotPasswordState.error',
        () async {
          const errorMessage = 'No user found with this email address';

          when(() => repository.forgotPassword(email: any(named: 'email')))
              .thenAnswer(
            (_) async => right(
              const FailureResponse(errorMessage),
            ),
          );

          expectLater(
            forgotPasswordNotifier.stream,
            emitsInOrder([
              const ForgotPasswordState.loading(),
              const ForgotPasswordState.error(errorMessage),
            ]),
          );

          forgotPasswordNotifier.forgotPassword(
              email: 'nonexistent@example.com');
        },
      );
    },
  );
}
