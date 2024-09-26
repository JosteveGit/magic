import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/register/register_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/register/register_state.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepositoryInterface {}

void main() {
  group(
    'RegisterNotifier',
    () {
      late AuthenticationRepositoryInterface repository;
      late RegisterNotifier registerNotifier;

      setUp(() {
        repository = MockAuthenticationRepository();
        registerNotifier = RegisterNotifier(repo: repository);
      });

      test('successful registration updates state to RegisterState.success',
          () async {
        final user = UserModel(
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
          uid: 'uid',
        );

        when(
          () => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
          ),
        ).thenAnswer(
          (_) async => left(user),
        );

        expectLater(
          registerNotifier.stream,
          emitsInOrder([
            const RegisterState.loading(),
            const RegisterState.success(),
          ]),
        );

        registerNotifier.register(
          email: 'test@example.com',
          password: 'password',
          firstName: 'Test',
          lastName: 'User',
        );
      });

      test('registration failure updates state to RegisterState.error',
          () async {
        const errorMessage = 'Registration failed';

        when(
          () => repository.register(
            email: any(named: 'email'),
            password: any(named: 'password'),
            firstName: any(named: 'firstName'),
            lastName: any(named: 'lastName'),
          ),
        ).thenAnswer((_) async => right(const FailureResponse(errorMessage)));

        expectLater(
          registerNotifier.stream,
          emitsInOrder([
            const RegisterState.loading(),
            const RegisterState.error(errorMessage),
          ]),
        );

        registerNotifier.register(
          email: 'wrong@example.com',
          password: 'wrongpassword',
          firstName: 'Wrong',
          lastName: 'Name',
        );
      });
    },
  );
}
