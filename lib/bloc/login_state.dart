part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  final int  OTP;
  const LoginInitial({required this.OTP});
  @override
  List<Object> get props => [OTP];
}
