import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/auth/bloc/authentication_bloc.dart';
import 'package:shopping/auth/bloc/authentication_event.dart';
import 'package:shopping/auth/login/bloc/login_bloc.dart';
import 'package:shopping/auth/login/bloc/login_event.dart';
import 'package:shopping/auth/login/bloc/login_state.dart';
import 'package:shopping/widgets/custom-button.dart';
import 'package:shopping/widgets/custom-text-field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var defaultStyleText = TextStyle(color: Colors.black);
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: padding.height * 0.05),
            child: BlocListener<LoginBloc, LoginState>(listener: (context, state) {

              if (state.isFailure) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Error'), Icon(Icons.error)],
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
              }
              if (state.isSubmitting) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Ingresando'),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ));
              }
              if (state.isSuccess) {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                Navigator.of(context).pop();
              }
            },
              child: Container(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Spacer(flex:4),
                      Text('Inicia sesion',
                          style: TextStyle(fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.amber, fontSize: 22)),
                      Spacer(flex:2),
                      Expanded(
                        flex: 13,
                        child: Padding(
                          padding: EdgeInsets.all(padding.width*0.05),
                          child: ListView(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Correo electrónico',
                                    style: TextStyle(fontWeight: FontWeight.normal)
                                        .copyWith(color: Colors.amber, fontSize: 15)),
                              ),
                              CustomTextField(
                                controller: _emailController,
                                isMail: true,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Contraseña',
                                    style: TextStyle(fontWeight: FontWeight.normal)
                                        .copyWith(color: Colors.amber, fontSize: 15)),
                              ),
                              CustomTextField(
                                  controller: _passwordController,),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex:4),
                      CustomButton(tittle: 'Continuar',onTap: _onFormSubmitted, circularBorder: true,),
                      Spacer(flex:1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentials(
        email: _emailController.text, password: _passwordController.text));
  }

}
