import 'dart:async';

import 'package:a_new_project_in_flutter/components/my_alert_dialog.dart';
import 'package:a_new_project_in_flutter/components/my_controllers.dart';
import 'package:a_new_project_in_flutter/utils/my_colors.dart';
import 'package:a_new_project_in_flutter/utils/my_strings.dart';
import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _btnEnabled = false, _textVisible = false;
  String _comingSms = 'Unknown';

  Future<void> initSmsListener() async {
    String comingSms;
    try {
      comingSms = (await AltSmsAutofill().listenForSms)!;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms;
      print("====>Message: ${_comingSms}");
      print("${_comingSms[32]}");

      if (_comingSms[0] == 'Y' &&
          _comingSms[1] == 'o' &&
          _comingSms[2] == 'u' &&
          _comingSms[3] == 'r') {
        MyControllers.loginOtp.text =
            _comingSms[32] + _comingSms[33] + _comingSms[34] + _comingSms[35];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Image.asset(
                  'images/app_logo.png',
                  scale: 0.90,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            const Text(
              MyStrings.signInToYourAccount,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                children: const [
                  Flexible(
                    child: Text(
                      MyStrings
                          .pleaseEnterYourMobileNumberInOrderToAuthenticate,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: const Text(
                    MyStrings.mobileNumber,
                    style: TextStyle(color: MyColors.textGrey),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextFormField(
                  onChanged: (phoneNo) {
                    if (phoneNo.length == 10) {
                      setState(() {
                        _btnEnabled = true;
                      });
                    } else {
                      setState(() {
                        _btnEnabled = false;
                      });
                    }
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)
                  ],
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.unselectedTextField)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: MyColors.selectedTextField)),
                    isDense: true,
                    prefixIcon: Text(
                      "+95 - ",
                      style: TextStyle(fontSize: 16),
                    ),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 0, minHeight: 0),
                    hintText: '9XXXXXXXXX',
                  ),
                  controller: MyControllers.loginPhoneNum),
            ),
            Container(
              height: 5,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text(
                      MyStrings.invalidNum,
                      style: TextStyle(
                          color: _textVisible
                              ? MyColors.buttonRed
                              : MyColors.screenBgColor),
                    )),
              ],
            ),
            Container(
              height: 40,
            ),
            SizedBox(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            color: _btnEnabled
                                ? MyColors.buttonRed
                                : MyColors.buttonLightRed),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_btnEnabled) {
                          setState(() {});
                          Fluttertoast.showToast(
                              msg: "+95" + MyControllers.loginPhoneNum.text,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          // Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => TestOtpScreen()));
                          openOtpVerificationDialog();
                          // MyPopUpDialog.getInstance()!.showPopUpDialog(context);
                        } else {
                          setState(() {
                            if (!_btnEnabled) {
                              _textVisible = true;
                            }
                          });
                        }
                      },
                      child: const Center(child: Text(MyStrings.requestOtp)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        color: MyColors.screenBgColor,
      ),
    );
  }

  @override
  void dispose() {
    MyControllers.loginOtp.dispose();
    AltSmsAutofill().unregisterListener();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    MyControllers.loginOtp = TextEditingController();
    initSmsListener();
  }

  void openOtpVerificationDialog() {
    bool _otpBtnEnabled = false, _errorTextVisible = false;
    String otp = "";
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(30)),
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 1.4,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              MyControllers.loginOtp.clear();
                            },
                            icon:
                                SvgPicture.asset("images/cross_icon_black.svg"),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                    ),
                    const Text(
                      MyStrings.otpVerification,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      MyStrings.otpSentMsg,
                      style: TextStyle(color: MyColors.textGrey, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),
                    const Text(MyStrings.enterOtp,
                        style: TextStyle(fontSize: 18),
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
                            setState(() {
                              _otpBtnEnabled = true;
                              print(otpText);
                            });
                          } else {
                            setState(() {
                              print(otpText);
                              _otpBtnEnabled = false;
                            });
                          }
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyColors.unselectedTextField)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: MyColors.selectedTextField)),
                            isDense: true,
                            hintText: "XXXX"),
                        controller: MyControllers.loginOtp,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(children: [
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      Container(
                        child: Flexible(
                          child: Text(
                            MyStrings.pleaseEnterValidOtp,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: _errorTextVisible
                                    ? MyColors.errorTextRed
                                    : MyColors.white),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      ),
                    ]),
                    const SizedBox(height: 40),
                    InkWell(
                        child: const Text(MyStrings.resendOtp,
                            style: TextStyle(fontSize: 18)),
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "Resending OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          if (_otpBtnEnabled) {
                            if (MyControllers.loginOtp.text == '1234') {
                              MyAlertDialog.getInstance()!.showAlertDialog(
                                  context,
                                  '',
                                  'OTP verification complete',
                                  false);
                            } else {
                              MyAlertDialog.getInstance()!.showAlertDialog(
                                  context, '', 'Invalid OTP', true);
                            }
                          } else {
                            if (!_otpBtnEnabled) {
                              setState(() {
                                _errorTextVisible = true;
                              });
                            }
                          }
                        },
                        child: const Text(MyStrings.verify),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: _otpBtnEnabled
                              ? MaterialStateProperty.all<Color>(
                                  MyColors.buttonRed)
                              : MaterialStateProperty.all<Color>(
                                  MyColors.buttonLightRed),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
    /* Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    }); */
  }
}
