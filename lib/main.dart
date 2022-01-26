import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/home/home_page.dart';
import 'auth/bloc/authentication_bloc.dart';
import 'auth/bloc/authentication_event.dart';
import 'auth/bloc/authentication_state.dart';
import 'auth/login/login_page.dart';
import 'auth/register/register_page.dart';
import 'auth/repository/user_repository.dart';
import 'cart/cart_page.dart';
import 'init_page.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final UserRepository userRepository = UserRepository();
  runApp(
      BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted()),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is Authenticated) {
            return HomePage();
          }
          if (state is Unauthenticated) {
            return InitPage();
          }
          return Container();
        },
      ),
      routes: {
        CartPage.routeName: (_) => CartPage(),
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
      },
    );
  }
}