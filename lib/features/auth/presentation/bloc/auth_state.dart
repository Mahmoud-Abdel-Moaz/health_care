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

class ChangeRegisterPasswordVisibilityState extends AuthState {
  final bool visible;

  const ChangeRegisterPasswordVisibilityState(this.visible);
  @override
  List<Object> get props => [visible];
}

class ChangeRegisterPasswordVerifyVisibilityState extends AuthState {
  final bool visible;

  const ChangeRegisterPasswordVerifyVisibilityState(this.visible);
  @override
  List<Object> get props => [visible];
}

class ChangeSelectedDateState extends AuthState {
  final DateTime dateTime;

  const ChangeSelectedDateState(this.dateTime);
  @override
  List<Object> get props => [dateTime];
}

class ChangeVaccineDateState extends AuthState {
  final DateTime dateTime;

  const ChangeVaccineDateState(this.dateTime);
  @override
  List<Object> get props => [dateTime];
}

class ChangeSelectedGenderState extends AuthState {
  final String gender;

  const ChangeSelectedGenderState(this.gender);
  @override
  List<Object> get props => [gender];
}

class ChangeSelectedBloodTypeState extends AuthState {
  final String bloodType;

  const ChangeSelectedBloodTypeState(this.bloodType);
  @override
  List<Object> get props => [bloodType];
}

class LoadingCreateAccountState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadedCreateAccountState extends AuthState {
  @override
  List<Object> get props => [];
}

class ErrorCreateAccountState extends AuthState {
  final String message;

  const ErrorCreateAccountState(this.message);
  @override
  List<Object> get props => [message];
}
class LoadingLoginState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadedLoginState extends AuthState {
  @override
  List<Object> get props => [];
}

class ErrorLoginState extends AuthState {
  final String message;

  const ErrorLoginState(this.message);
  @override
  List<Object> get props => [message];
}


class LoadingGetUserInfoState extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadedGetUserInfoState extends AuthState {
  final FullUserInfo userInfo;
  const LoadedGetUserInfoState(this.userInfo);
  @override
  List<Object> get props => [userInfo];
}

class ErrorGetUserInfoState extends AuthState {
  final String message;

  const ErrorGetUserInfoState(this.message);
  @override
  List<Object> get props => [message];
}

