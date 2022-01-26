import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String tittle;
  final Function onTap;
  final circularBorder;
  const TransparentButton({Key key,@required this.tittle,@required this.onTap, @required this.circularBorder}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return buttonTransparentWidget(context);
  }

  Widget buttonTransparentWidget(context) {
    return Container(
      height: 50.0,
      child: RaisedButton(
        onPressed: onTap,
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.amber),borderRadius: BorderRadius.circular(!circularBorder?10.0:80.0)),
        padding: EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(!circularBorder?10.0:30.0)
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
            alignment: Alignment.center,
            child: Text(
              tittle,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 16
              ),
            )
          ),
        ),
      ),
    );
  }
}