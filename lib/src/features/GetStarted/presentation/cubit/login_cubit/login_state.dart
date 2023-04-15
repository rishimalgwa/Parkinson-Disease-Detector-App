part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginuserLoading extends LoginState {}

class LoginuserError extends LoginState {
  final String error;

  const LoginuserError(this.error);
}

class LoginuserSuccess extends LoginState {
  final AuthResponse res;

  const LoginuserSuccess(this.res);
}
