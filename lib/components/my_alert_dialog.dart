import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:a_new_project_in_flutter/utils/my_colors.dart';
import 'package:a_new_project_in_flutter/utils/my_strings.dart';

class MyAlertDialog {
  static MyAlertDialog? myAlertDialog = null;

  static MyAlertDialog? getInstance() {
    if (myAlertDialog == null) {
      myAlertDialog = MyAlertDialog();
    }
    return myAlertDialog;
  }

  showAlertDialog(BuildContext context, String alertTitle, String alertMessage,
      bool isError) {
    double height = (MediaQuery.of(context).size.height / 1.4) / 5;
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isError ? Colors.red : MyColors.confirmGreen,
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.4,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset("images/cross_icon.svg"),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(height: height),
                SvgPicture.asset(
                    isError
                        ? "images/cross_icon.svg"
                        : "images/dialog_tick.svg",
                    height: 200,
                    width: 200),
                Container(height: 40),
                Text(
                  alertMessage,
                  style: const TextStyle(
                      color: MyColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )
              ],
            ),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
