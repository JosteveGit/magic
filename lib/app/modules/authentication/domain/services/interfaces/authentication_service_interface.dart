import 'package:magic/app/modules/authentication/data/models/user_model.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';

abstract interface class AuthenticationServiceInterface {
  ApiFuture<UserModel> login({
    required String email,
    required String password,
  });
  ApiFuture<UserModel> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  ApiFuture<void> forgotPassword({
    required String email,
  });
}
