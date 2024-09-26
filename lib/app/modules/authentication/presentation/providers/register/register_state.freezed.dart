// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RegisterState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateInitial value) initial,
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateSuccess value) success,
    required TResult Function(RegisterStateError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterStateInitial value)? initial,
    TResult? Function(RegisterStateLoading value)? loading,
    TResult? Function(RegisterStateSuccess value)? success,
    TResult? Function(RegisterStateError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateInitial value)? initial,
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateSuccess value)? success,
    TResult Function(RegisterStateError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterStateCopyWith<$Res> {
  factory $RegisterStateCopyWith(
          RegisterState value, $Res Function(RegisterState) then) =
      _$RegisterStateCopyWithImpl<$Res, RegisterState>;
}

/// @nodoc
class _$RegisterStateCopyWithImpl<$Res, $Val extends RegisterState>
    implements $RegisterStateCopyWith<$Res> {
  _$RegisterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RegisterStateInitialImplCopyWith<$Res> {
  factory _$$RegisterStateInitialImplCopyWith(_$RegisterStateInitialImpl value,
          $Res Function(_$RegisterStateInitialImpl) then) =
      __$$RegisterStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateInitialImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterStateInitialImpl>
    implements _$$RegisterStateInitialImplCopyWith<$Res> {
  __$$RegisterStateInitialImplCopyWithImpl(_$RegisterStateInitialImpl _value,
      $Res Function(_$RegisterStateInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterStateInitialImpl implements RegisterStateInitial {
  const _$RegisterStateInitialImpl();

  @override
  String toString() {
    return 'RegisterState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateInitial value) initial,
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateSuccess value) success,
    required TResult Function(RegisterStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterStateInitial value)? initial,
    TResult? Function(RegisterStateLoading value)? loading,
    TResult? Function(RegisterStateSuccess value)? success,
    TResult? Function(RegisterStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateInitial value)? initial,
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateSuccess value)? success,
    TResult Function(RegisterStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RegisterStateInitial implements RegisterState {
  const factory RegisterStateInitial() = _$RegisterStateInitialImpl;
}

/// @nodoc
abstract class _$$RegisterStateLoadingImplCopyWith<$Res> {
  factory _$$RegisterStateLoadingImplCopyWith(_$RegisterStateLoadingImpl value,
          $Res Function(_$RegisterStateLoadingImpl) then) =
      __$$RegisterStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateLoadingImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterStateLoadingImpl>
    implements _$$RegisterStateLoadingImplCopyWith<$Res> {
  __$$RegisterStateLoadingImplCopyWithImpl(_$RegisterStateLoadingImpl _value,
      $Res Function(_$RegisterStateLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterStateLoadingImpl implements RegisterStateLoading {
  const _$RegisterStateLoadingImpl();

  @override
  String toString() {
    return 'RegisterState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateInitial value) initial,
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateSuccess value) success,
    required TResult Function(RegisterStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterStateInitial value)? initial,
    TResult? Function(RegisterStateLoading value)? loading,
    TResult? Function(RegisterStateSuccess value)? success,
    TResult? Function(RegisterStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateInitial value)? initial,
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateSuccess value)? success,
    TResult Function(RegisterStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RegisterStateLoading implements RegisterState {
  const factory RegisterStateLoading() = _$RegisterStateLoadingImpl;
}

/// @nodoc
abstract class _$$RegisterStateSuccessImplCopyWith<$Res> {
  factory _$$RegisterStateSuccessImplCopyWith(_$RegisterStateSuccessImpl value,
          $Res Function(_$RegisterStateSuccessImpl) then) =
      __$$RegisterStateSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RegisterStateSuccessImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterStateSuccessImpl>
    implements _$$RegisterStateSuccessImplCopyWith<$Res> {
  __$$RegisterStateSuccessImplCopyWithImpl(_$RegisterStateSuccessImpl _value,
      $Res Function(_$RegisterStateSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RegisterStateSuccessImpl implements RegisterStateSuccess {
  const _$RegisterStateSuccessImpl();

  @override
  String toString() {
    return 'RegisterState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateInitial value) initial,
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateSuccess value) success,
    required TResult Function(RegisterStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterStateInitial value)? initial,
    TResult? Function(RegisterStateLoading value)? loading,
    TResult? Function(RegisterStateSuccess value)? success,
    TResult? Function(RegisterStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateInitial value)? initial,
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateSuccess value)? success,
    TResult Function(RegisterStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RegisterStateSuccess implements RegisterState {
  const factory RegisterStateSuccess() = _$RegisterStateSuccessImpl;
}

/// @nodoc
abstract class _$$RegisterStateErrorImplCopyWith<$Res> {
  factory _$$RegisterStateErrorImplCopyWith(_$RegisterStateErrorImpl value,
          $Res Function(_$RegisterStateErrorImpl) then) =
      __$$RegisterStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RegisterStateErrorImplCopyWithImpl<$Res>
    extends _$RegisterStateCopyWithImpl<$Res, _$RegisterStateErrorImpl>
    implements _$$RegisterStateErrorImplCopyWith<$Res> {
  __$$RegisterStateErrorImplCopyWithImpl(_$RegisterStateErrorImpl _value,
      $Res Function(_$RegisterStateErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RegisterStateErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RegisterStateErrorImpl implements RegisterStateError {
  const _$RegisterStateErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RegisterState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterStateErrorImplCopyWith<_$RegisterStateErrorImpl> get copyWith =>
      __$$RegisterStateErrorImplCopyWithImpl<_$RegisterStateErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RegisterStateInitial value) initial,
    required TResult Function(RegisterStateLoading value) loading,
    required TResult Function(RegisterStateSuccess value) success,
    required TResult Function(RegisterStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RegisterStateInitial value)? initial,
    TResult? Function(RegisterStateLoading value)? loading,
    TResult? Function(RegisterStateSuccess value)? success,
    TResult? Function(RegisterStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RegisterStateInitial value)? initial,
    TResult Function(RegisterStateLoading value)? loading,
    TResult Function(RegisterStateSuccess value)? success,
    TResult Function(RegisterStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RegisterStateError implements RegisterState {
  const factory RegisterStateError(final String message) =
      _$RegisterStateErrorImpl;

  String get message;

  /// Create a copy of RegisterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterStateErrorImplCopyWith<_$RegisterStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
