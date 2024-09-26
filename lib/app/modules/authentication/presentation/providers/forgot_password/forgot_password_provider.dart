import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:magic/app/modules/authentication/domain/repositories/authentication_repository.dart';
import 'package:magic/app/modules/authentication/domain/repositories/interfaces/authentication_repository_interface.dart';
import 'package:magic/app/modules/authentication/presentation/providers/forgot_password/forgot_password_state.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>((ref) {
  final repo = ref.read(authenticationRepositoryProvider);
  return ForgotPasswordNotifier(repo: repo);
});

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  final AuthenticationRepositoryInterface repo;
  ForgotPasswordNotifier({required this.repo})
      : super(const ForgotPasswordState.initial());

  void forgotPassword({
    required String email,
  }) async {
    state = const ForgotPasswordState.loading();
    final response = await repo.forgotPassword(email: email);
    response.fold(
      (_) => state = const ForgotPasswordState.success(),
      (error) => state = ForgotPasswordState.error(error.message),
    );
  }
}
