import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent{
  final String email;
  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent{
  final String password;
  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class Submitted extends LoginEvent{
  final String email;
  final String password;

  const Submitted({@required this.email, @required this.password});

  @override
  List<Object> get props => [email,password];
}

class LoginWithCredentials extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentials({@required this.email, @required this.password});

  @override
  List<Object> get props => [email,password];
}
