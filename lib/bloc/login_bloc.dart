import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial(OTP: 0));
  @override
  Stream<LoginState> mapEventState(LoginEvent event) async*{
    if(event is GetOTP){
      yield LoginInitial(OTP: 0);

    }

  }


  }



