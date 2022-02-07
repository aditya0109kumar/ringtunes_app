import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyControllers {
  // login page
  static TextEditingController loginPhoneNum = TextEditingController();
  static TextEditingController loginOtp = TextEditingController();
}

class CommonStyle{
  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""}) {return InputDecoration(
    contentPadding: EdgeInsets.all(12),
    labelText: labelTextStr,
    hintText:hintTextStr,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );}
}
