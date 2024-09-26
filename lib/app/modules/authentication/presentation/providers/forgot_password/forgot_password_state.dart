import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = ForgotPasswordStateInitial;
  const factory ForgotPasswordState.loading() = ForgotPasswordStateLoading;
  const factory ForgotPasswordState.success() = ForgotPasswordStateSuccess;
  const factory ForgotPasswordState.error(String message) = ForgotPasswordStateError;
}
