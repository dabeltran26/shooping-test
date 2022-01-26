import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final Function onIconPressed;
  final bool isMail;

  CustomTextField({
    Key key,
    @required this.controller,
    this.maxLines = 1,
    this.onIconPressed,
    this.isMail = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 15,color: Colors.amber),
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        FocusScope.of(context).nextFocus();
      },
      keyboardType: isMail ? TextInputType.emailAddress:TextInputType.text ,
      maxLines: maxLines,
      controller: controller,
      textCapitalization: TextCapitalization.none,
      decoration: InputDecoration(
        hintStyle: TextStyle().copyWith(color: Colors.amber,fontSize: 15),
        border: OutlineInputBorder(),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber, width: 2.0),
        ),
        contentPadding: EdgeInsets.all(15),
      ),
    );
  }
}
