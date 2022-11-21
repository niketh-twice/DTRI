import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dtrip_login/home/ui/dashboard.dart';
import 'package:dtrip_login/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../db/api.dart';
import 'login_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.white10.withAlpha(80)),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withAlpha(100),
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                AutoSizeText(
                                  "Sign Up",
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
                                      controller: nameController,
                                      decoration: InputDecoration(
                                          hintText: 'Name',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Metropolis',
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Metropolis',
                                          ),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                    child: IntlPhoneField(
                                      controller: phoneController,
                                      textAlign: TextAlign.justify,
                                      autovalidateMode: AutovalidateMode.disabled,
                                        disableLengthCheck: true,
                                      showCountryFlag: true,
                                        showDropdownIcon: false,
                                        decoration: InputDecoration(
                                            hintText: 'Phone',
                                            hintStyle: TextStyle(
                                              fontFamily: 'Metropolis',
                                            ),
                                            border: InputBorder.none,
                                            counter: null,
                                        counterText: null),
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      initialCountryCode: 'IN',
                                      onChanged: (phone) {
                                        print(phone.completeNumber);
                                      },
                                    ),
                                    // TextFormField(
                                    //   textAlign: TextAlign.center,
                                    //   // maxLength: 10,
                                    //   controller: phoneController,
                                    //   decoration: InputDecoration(
                                    //       hintText: 'Phone',
                                    //       hintStyle: TextStyle(
                                    //         fontFamily: 'Metropolis',
                                    //       ),
                                    //       border: InputBorder.none,
                                    //       counterText: null),
                                    //   keyboardType: TextInputType.phone,
                                    //   inputFormatters: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.digitsOnly
                                    //   ],
                                    // ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                        left: 50, right: 10),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: passwordController1,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Metropolis',
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            child: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black26,
                                              size: 30,
                                            ),
                                          ),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
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
                                      controller: passwordController2,
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          hintText: 'Confirm Password',
                                          hintStyle: TextStyle(
                                            fontFamily: 'Metropolis',
                                          ),
                                          border: InputBorder.none),
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
                                      signup();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 20.0),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Sign Up",
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
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Text(
                      //         '- OR -',
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             fontFamily: 'Metropolis',
                      //             color: Colors.black,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30),
                      //   child: Container(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         SignInButton.mini(
                      //             buttonType: ButtonType.google,
                      //             buttonSize: ButtonSize.large,
                      //             onPressed: () {
                      //               GsignUp();
                      //               print('click');
                      //             }),
                      //         SignInButton.mini(
                      //             buttonType: ButtonType.facebook,
                      //             buttonSize: ButtonSize.large,
                      //             onPressed: () {
                      //               print('click');
                      //             }),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a member?',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.off(
                                  () => LoginPage(),
                                  transition: Transition.circularReveal,
                                  duration: Duration(milliseconds: 500),
                                );
                              },
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Metropolis',
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 50,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signup() async {
    if (emailController.text.isEmpty &&
        nameController.text.isEmpty &&
        phoneController.text.isEmpty &&
        passwordController1.text.isEmpty &&
        passwordController2.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "All Fields Must Be Filled",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xff55327a),
                  fontSize: MediaQuery.of(context).textScaleFactor * 14,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (emailController.text.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(emailController.text)) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "Enter A Valid Email",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xff55327a),
                  fontSize: MediaQuery.of(context).textScaleFactor * 14,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (phoneController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "Enter A Valid Phone Number",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xff55327a),
                  fontSize: MediaQuery.of(context).textScaleFactor * 14,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (passwordController1.text.isEmpty ||
        passwordController1.text.length < 8) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "Enter A Valid Password",
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Password must be 8 characters",
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xff55327a),
                  fontSize: MediaQuery.of(context).textScaleFactor * 14,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (passwordController1.text != passwordController2.text) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "Both Passwords Must Be Same",
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                "OK",
                style: TextStyle(
                  color: Color(0xff55327a),
                  fontSize: MediaQuery.of(context).textScaleFactor * 14,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      print("Validation Success");
      final response = await http.post(
        Uri.parse(api + 'api/auth/signup'),
        body: jsonEncode({
          "username": emailController.text,
          "email": emailController.text,
          "name": nameController.text,
          "password": passwordController1.text,
          "phone": phoneController.text
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Get.to(Dashboard());
      } else if (response.statusCode == 422) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            title: Text(
              "Email already taken",
              textAlign: TextAlign.center,
            ),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "The email you entered is already registred.",
                textAlign: TextAlign.center,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              OutlinedButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Color(0xff55327a),
                    fontSize: MediaQuery.of(context).textScaleFactor * 14,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xffebedf8)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        print("Failed to signup");
      }
    }
  }
}
