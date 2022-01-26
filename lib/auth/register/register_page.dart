import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/auth/repository/user_repository.dart';
import 'bloc/register_bloc.dart';
import 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  static const routeName = 'register';
  UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
    );
  }
}
