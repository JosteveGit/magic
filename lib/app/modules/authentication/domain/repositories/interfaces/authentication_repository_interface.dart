import 'package:magic/app/shared/helpers/classes/failures.dart';

abstract interface class AuthenticationRepositoryInterface {
  ApiFuture<void> login({
    required String email,
    required String password,
  });
  ApiFuture<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  ApiFuture<void> forgotPassword({
    required String email,
  });
}
