import 'package:flutter/material.dart';
import 'package:shopping/widgets/custom-button.dart';
import 'package:shopping/widgets/transparent-button.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding:EdgeInsets.only(top: padding.height*0.5),
            child: Container(
              child: Column(
                children: <Widget>[
                  CustomButton(tittle: 'Crear cuenta',onTap: goRegister, circularBorder: true,),
                  SizedBox(height: 8,),
                  TransparentButton(tittle: 'Iniciar sesión',onTap: goLogin, circularBorder: true,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void goRegister(){
    Navigator.pushNamed(context, 'register');
  }

  void goLogin() {
    Navigator.pushNamed(context, 'login');
  }
}

