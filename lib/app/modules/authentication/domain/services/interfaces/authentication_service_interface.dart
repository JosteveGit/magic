import 'package:magic/app/shared/helpers/classes/failures.dart';

abstract interface class AuthenticationServiceInterface {
  ApiFuture<String> login({
    required String email,
    required String password,
  });
  ApiFuture<String> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  ApiFuture<void> forgotPassword({
    required String email,
  });
}
