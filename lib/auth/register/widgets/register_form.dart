import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/auth/bloc/authentication_bloc.dart';
import 'package:shopping/auth/bloc/authentication_event.dart';
import 'package:shopping/auth/register/bloc/register_bloc.dart';
import 'package:shopping/auth/register/bloc/register_event.dart';
import 'package:shopping/auth/register/bloc/register_state.dart';
import 'package:shopping/widgets/custom-button.dart';
import 'package:shopping/widgets/custom-text-field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  RegisterBloc _registerBloc;
  var defaultStyleText = TextStyle(color: Colors.black);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
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
            child: BlocListener<RegisterBloc, RegisterState>(
              listener: (context, state) {

                if (state.isSubmitting) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Registrando'),
                          CircularProgressIndicator()
                        ],
                      ),
                    ));
                }
                if (state.isSuccess) {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                  Navigator.of(context).pop();
                }
                if (state.isFailure) {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Registro fallido'),
                          Icon(Icons.error)
                        ],
                      ),
                      backgroundColor: Colors.red,
                    ));
                }
              },

              child: Container(
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Spacer(flex:4),
                      Text('Crea una cuenta',
                          style: TextStyle(fontWeight: FontWeight.bold)
                              .copyWith(color: Colors.amber, fontSize: 22)),
                      Spacer(flex:2),
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsets.all(padding.width*0.05),
                          child: ListView(
                            children: [
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
    _registerBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _registerBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(Submitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
