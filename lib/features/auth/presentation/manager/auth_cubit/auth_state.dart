abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFailure extends AuthState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String errorMessage;
  LoginFailure(this.errorMessage);
}

class ValidateSuccess extends AuthState {}

class ValidateFailure extends AuthState {}
