import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/domain/services/authentication_service.dart';
import 'package:magic/app/modules/authentication/domain/services/interfaces/authentication_service_interface.dart';
import 'package:magic/app/shared/extensions/dart_z_extension.dart';
import 'package:magic/app/shared/helpers/classes/failures.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences.dart';
import 'package:magic/app/shared/helpers/classes/preferences/preferences_strings.dart';

final authenticationRepositoryProvider =
    Provider<AuthenticationRepositoryInterface>((ref) {
  final service = ref.read(authenticationServiceProvider);
  return AuthenticationRepository(service: service);
});

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  final AuthenticationServiceInterface service;

  AuthenticationRepository({required this.service});
  @override
  ApiFuture<void> forgotPassword({required String email}) {
    return service.forgotPassword(email: email);
  }

  @override
  ApiFuture<void> login({
    required String email,
    required String password,
  }) async {
    final response = await service.login(email: email, password: password);
    if (response.isLeft()) {
      Preferences.setModel(
          key: PreferencesStrings.userModel, model: response.left);
    }
    return response;
  }

  @override
  ApiFuture<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await service.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    if (response.isLeft()) {
      Preferences.setModel(
          key: PreferencesStrings.userModel, model: response.left);
    }
    return response;
  }
}
