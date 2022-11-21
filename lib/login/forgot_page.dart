import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dtrip_login/login/login_controller.dart';
import 'package:dtrip_login/login/otp_page.dart';
import 'package:dtrip_login/login/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:http/http.dart' as http;

class ForgotPage extends StatefulWidget {
  const ForgotPage({
    super.key,
  });

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
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
                          height: 200,
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
                                    "Forgot Password?",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xccffffff),
                                          Color(0xccffffff)
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 50),
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        // validator: (value) {
                                        //
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'Please enter Card Number';
                                        //   } return null;
                                        // },
                                        //controller: cardController,
                                        decoration: InputDecoration(
                                            hintText: 'Email',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Metropolis',
                                            ),
                                            border: InputBorder.none),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
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
                                        Get.to(OtpPage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.0, vertical: 20.0),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        shape: StadiumBorder(),
                                      ),
                                      child: Text(
                                        "Next",
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
                          height: 50,
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
}
