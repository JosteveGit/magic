import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/register/register_state.dart';

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final repo = ref.read(authenticationRepositoryProvider);
  return RegisterNotifier(repo: repo);
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthenticationRepositoryInterface repo;
  RegisterNotifier({required this.repo}) : super(const RegisterState.initial());

  void register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = const RegisterState.loading();
    final response = await repo.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    response.fold(
      (_) => state = const RegisterState.success(),
      (error) => state = RegisterState.error(error.message),
    );
  }
}
