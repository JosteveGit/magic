import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/login/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repo = ref.read(authenticationRepositoryProvider);
  return LoginNotifier(repo: repo);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthenticationRepositoryInterface repo;
  LoginNotifier({required this.repo}) : super(const LoginState.initial());

  void login({
    required String email,
    required String password,
  }) async {
    state = const LoginState.loading();
    final response = await repo.login(
      email: email,
      password: password,
    );
    response.fold(
      (_) => state = const LoginState.success(),
      (error) => state = LoginState.error(error.message),
    );
  }
}
