import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String tittle;
  final Function onTap;
  final circularBorder;
  const CustomButton({Key key,@required this.tittle,@required this.onTap, @required this.circularBorder}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return buttonColorsWidget(context);
  }

  Widget buttonColorsWidget(context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(!circularBorder?10.0:80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.amber, Colors.red],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(!circularBorder?10.0:30.0)
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              tittle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16
              ),
            )
          ),
        ),
      ),
    );
  }
}