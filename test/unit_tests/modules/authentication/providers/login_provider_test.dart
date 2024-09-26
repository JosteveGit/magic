import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/login/login_provider.dart';
import 'package:magic/app/modules/authentication/presentation/providers/login/login_state.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepositoryInterface {}

void main() {
  group('LoginNotifier', () {
    late AuthenticationRepositoryInterface repository;
    late LoginNotifier loginNotifier;

    setUp(() {
      repository = MockAuthenticationRepository();
      loginNotifier = LoginNotifier(repo: repository);
    });

    test('login success should update state to LoginState.success', () async {
      final user = UserModel(
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
        uid: 'uid',
      );

      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => left(user),
      );

      expectLater(
        loginNotifier.stream,
        emitsInOrder(
          [
            const LoginState.loading(),
            const LoginState.success(),
          ],
        ),
      );

      loginNotifier.login(email: 'test@example.com', password: 'password');
    });

    test('login failure should update state to LoginState.error', () async {
      const errorMessage = 'Invalid credentials';

      when(
        () => repository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => right(const FailureResponse(errorMessage)));

      expectLater(
        loginNotifier.stream,
        emitsInOrder(
          [
            const LoginState.loading(),
            const LoginState.error(errorMessage),
          ],
        ),
      );

      loginNotifier.login(
        email: 'wrong@example.com',
        password: 'wrongpassword',
      );
    });
  });
}
