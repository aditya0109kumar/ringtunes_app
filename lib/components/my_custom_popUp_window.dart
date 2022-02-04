import 'package:a_new_project_in_flutter/components/my_controllers.dart';
import 'package:a_new_project_in_flutter/utils/my_colors.dart';
import 'package:a_new_project_in_flutter/utils/my_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';

class MyPopUpDialog {
  static MyPopUpDialog? myPopUpDialog = null;

  static MyPopUpDialog? getInstance() {
    if (myPopUpDialog == null) {
      myPopUpDialog = MyPopUpDialog();
    }
    return myPopUpDialog;
  }

  showPopUpDialog(BuildContext context) {
    bool _otpBtnEnabled = false;
    String _comingSms = 'Unknown';
    

    Dialog popUp = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.4,
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: SvgPicture.asset("images/cross_icon_black.svg"),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
            ),
            const Text(
              MyStrings.otpVerification,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 50),
            const Text(
              MyStrings.otpSentMsg,
              style: TextStyle(color: MyColors.textGrey, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            const Text(MyStrings.enterOtp,
                style: TextStyle(color: MyColors.textDarkGrey, fontSize: 18),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
                onChanged: (otpText) {
                  if (otpText.length == 4) {
                    _otpBtnEnabled = true;
                  } else {
                    _otpBtnEnabled = false;
                  }
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.unselectedTextField)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.selectedTextField)),
                    isDense: true,
                    hintText: "XXXX"),
                controller: MyControllers.loginOtp,
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return popUp;
        });
  }
}
