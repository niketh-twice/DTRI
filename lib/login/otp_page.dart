import 'dart:async';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dtrip_login/login/reset_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class OtpPage extends StatefulWidget {
  const OtpPage({
    super.key,
  });

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final formKey5 = GlobalKey<FormState>();
  TextEditingController otpController1 = new TextEditingController();
  TextEditingController otpController2 = new TextEditingController();
  TextEditingController otpController3 = new TextEditingController();
  TextEditingController otpController4 = new TextEditingController();
  TextEditingController otpController5 = new TextEditingController();
  TextEditingController otpController6 = new TextEditingController();

  int secondsRemaining = 60;
  bool enableResend = false;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(181, 151, 246, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -50,
            top: Get.height * 0.1,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(62, 21, 78, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 100,
            bottom: Get.height * 0.35,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(146, 39, 143, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -50,
            bottom: Get.height * 0.075,
            child: Container(
              height: 225,
              width: 225,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(146, 39, 143, 1.0),
                    Color.fromRGBO(240, 78, 110, 1.0),
                  ],
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: GestureDetector(
                onTap: () {
                  if (!FocusScope.of(context).hasPrimaryFocus) {
                    FocusScope.of(context).unfocus();
                  }
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            image: new DecorationImage(
                              image: AssetImage(
                                  "assets/images/dtrips_logo_dark.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width / 1.2,
                        //   height: MediaQuery.of(context).size.height / 2.8,
                        //   decoration: BoxDecoration(
                        //     image: new DecorationImage(
                        //       image: AssetImage("assets/images/login1.png"),
                        //       fit: BoxFit.contain,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white10.withAlpha(80)),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withAlpha(100),
                                  blurRadius: 10.0,
                                  spreadRadius: 0.0,
                                ),
                              ],
                              color: Color(0xffffffff).withOpacity(0.1),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    "Enter the OTP send to",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  AutoSizeText(
                                    "test@gmail.com",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Metropolis',
                                        color: Color(0xff92278f),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xffffffff),
                                              Color(0xffffffff)
                                            ],
                                          ),
                                        ),
                                        child: TextFormField(
                                          maxLength: 1,
                                          autofocus: true,
                                          cursorColor: Color(0xFF92278F),
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            }
                                            // if (value.length == 0) {
                                            //   FocusScope.of(context).previousFocus();
                                            // }
                                          },

                                          textAlign: TextAlign.center,
                                          // validator: (value) {
                                          //   if (value == null ||
                                          //       value.isEmpty) {
                                          //     return '';
                                          //   }
                                          //   return null;
                                          // },
                                          controller: otpController1,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            counterText: '',
                                          ),

                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xffffffff),
                                              Color(0xffffffff)
                                            ],
                                          ),
                                        ),
                                        child: TextFormField(
                                          maxLength: 1,
                                          autofocus: false,
                                          cursorColor: Color(0xFF92278F),
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            } else if (value.length == 0) {
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          // validator: (value) {
                                          //   if (value == null ||
                                          //       value.isEmpty) {
                                          //     return '';
                                          //   }
                                          //   return null;
                                          // },
                                          controller: otpController2,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            counterText: '',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xffffffff),
                                              Color(0xffffffff)
                                            ],
                                          ),
                                        ),
                                        child: TextFormField(
                                          maxLength: 1,
                                          autofocus: false,
                                          cursorColor: Color(0xFF92278F),
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context)
                                                  .nextFocus();
                                            } else if (value.length == 0) {
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          // validator: (value) {
                                          //   if (value == null ||
                                          //       value.isEmpty) {
                                          //     return '';
                                          //   }
                                          //   return null;
                                          // },
                                          controller: otpController5,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            counterText: '',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14.0),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xffffffff),
                                              Color(0xffffffff)
                                            ],
                                          ),
                                        ),
                                        child: TextFormField(
                                          maxLength: 1,
                                          cursorColor: Color(0xFF92278F),
                                          autofocus: false,
                                          onChanged: (value) {
                                            if (value.length == 1) {
                                              FocusScope.of(context).unfocus();
                                            } else if (value.length == 0) {
                                              FocusScope.of(context)
                                                  .previousFocus();
                                            }
                                          },
                                          textAlign: TextAlign.center,
                                          // validator: (value) {
                                          //   if (value == null ||
                                          //       value.isEmpty) {
                                          //     return '';
                                          //   }
                                          //   return null;
                                          // },
                                          controller: otpController6,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            counterText: '',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Text(
                                  //       'Resend (00)',
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           fontFamily: 'Metropolis',
                                  //           color: Colors.black,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //   ],
                                  // ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            primary: Color(0xff92278f),
                                          ),
                                          onPressed:
                                              enableResend ? _resendCode : null,
                                          child: Text(
                                            "Resend",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.bold),
                                          )),
                                      AutoSizeText(
                                        enableResend
                                            ? ""
                                            : "($secondsRemaining)",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 4),
                                            blurRadius: 5.0)
                                      ],
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [0.0, 1.0],
                                        colors: [
                                          Color(0xff92278f),
                                          Color(0xff92278f),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(ResetPasswordPage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0, vertical: 20.0),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: 'Metropolis',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _resendCode() {
    //resend function

    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}
