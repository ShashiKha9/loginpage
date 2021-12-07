part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();


}
class GetOTP extends  LoginEvent{
   final  String PhoneNo;

  const GetOTP(this.PhoneNo);
   @override

   List<Object?> get props => [PhoneNo];





}
