part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class ChangePasswordVisibilityState extends AuthState {
  final bool visible;

  const ChangePasswordVisibilityState(this.visible);
  @override
  List<Object> get props => [visible];
}
