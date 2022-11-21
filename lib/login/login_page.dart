import 'dart:convert';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:dtrip_login/home/constant.dart';
import 'package:dtrip_login/home/ui/dashboard.dart';
import 'package:dtrip_login/login/forgot_page.dart';
import 'package:dtrip_login/login/login_controller.dart';
import 'package:dtrip_login/login/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:http/http.dart' as http;

import '../Shared/SharedPrefs.dart';
import '../db/Login/google_login_model.dart';
import '../db/api.dart';
import '../home/global.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {

    super.initState();
    getIp();
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
            top: Get.height * 0.15,
            child: Container(
              height: 180,
              width: 180,
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
              floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
              floatingActionButton: IconButton(
                onPressed: (){
                  //Get.back();
                  guestLogin();
                },
                icon: Icon(Icons.close),
                iconSize: 30,
                tooltip: 'Close',
              ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
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
                            color: Color(0xffffffff).withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                AutoSizeText(
                                  "Log In",
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
                                        left: 50, right: 10),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: passwordController,
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
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(ForgotPage());
                                      },
                                      child: Text(
                                        'Forgot ?',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                                      login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 20.0),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Metropolis',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '- OR -',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton.mini(
                                  buttonType: ButtonType.google,
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {
                                    GsignIn();
                                    print('click');
                                  }),
                              SignInButton.mini(
                                  buttonType: ButtonType.facebook,
                                  buttonSize: ButtonSize.large,
                                  onPressed: () {
                                    facebookLogin();
                                    print('click');
                                  }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New here?',
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
                                Get.to(
                                  () => SignUpPage(),
                                  transition: Transition.circularReveal,
                                  duration: Duration(milliseconds: 500),
                                );
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Metropolis',
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text("Or Login as a ",style: TextStyle(
                          //     fontSize: 16,
                          //     fontFamily: 'Metropolis',
                          //     color: Colors.black,
                          //     fontWeight: FontWeight.w400),),

                          // InkWell(
                          //   onTap: () {
                          //     guestLogin();
                          //   },
                          //   child: Text(
                          //     "Guest",
                          //     style: TextStyle(
                          //         fontSize: 18,
                          //         fontFamily: 'Metropolis',
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
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

  Future GsignIn() async {
    final user = await GoogleSignInApi.login();

    print(user);
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Failed')));
    } else {
      // Get.to(Dashboard());
      setState(() {
        username = user.displayName.toString();
        user.photoUrl == null
            ? userimg = ''
            : userimg = user.photoUrl.toString();
      });

      final response = await http.post(
        Uri.parse(api + 'api/auth/google-signin'),
        body: jsonEncode({
          "imageurl": user.photoUrl,
          "email": user.email,
          "name": user.displayName,
          "username": user.email,
          "password": user.id,
          // "id": user.id,
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.body);
      print(response.statusCode);
      final result = googleLoginFromJson(response.body);

      if (response.statusCode == 202) {
        setLogin('google');
        setName(result.username!);
        setEmail(result.email!);
        setJwt(result.jwtCookie!.value!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Account Created')));
        Get.to(Dashboard());
        setState(() {
          username = result.username!;
        });
      } else if (response.statusCode == 200) {
        setLogin('google');
        setName(result.username!);
        setEmail(result.email!);
        setJwt(result.jwtCookie!.value!);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Login')));
        print(result.jwtCookie!.value);
        print(",,,,,,,,,,,,,,,,");
        Get.to(Dashboard());
        setState(() {
          username = user.displayName.toString();
        });
      } else {
        removeLogin();
        removeEmail();
        removeName();
        removeJwt();
        await GoogleSignInApi.logout();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Something went wrong')));
      }
    }
  }

  facebookLogin() async {
    try {
      final result = await FacebookAuth.i.login(permissions: [
        'public_profile',
      ]);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print('facebook_login_data:-');
        print(userData);
        print('${userData['name']}');
        print('${userData['picture']['data']['url']}');
        print('${userData['id']}');
        setState(() {
          username = userData['name'];
          userimg = userData['picture']['data']['url'];
        });

        final response = await http.post(
          Uri.parse(api + 'api/facebook/facebook-signup'),
          body: jsonEncode({
            "imageurl": userData['picture']['data']['url'],
            "id": userData['id'],
            "username": userData['name'],
          }),
          headers: {"content-type": "application/json"},
        );
        print(response.body);
        print(response.statusCode);

        if (response.statusCode == 200) {
          print('fb login success');
          Get.to(Dashboard());
        } else if (response.statusCode == 201) {
          print('face book signup success');
          Get.to(Dashboard());
        } else {
          print('Something wrong');
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Facebook Login Failed')));
      }
    } catch (error) {
      print(error);
    }
  }

  void login() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(
            "Enter Email And Password",
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
    } else if (passwordController.text.isEmpty ||
        passwordController.text.length < 8) {
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
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Password needs atleast 8 characters",
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
      print("Validation Success");
      final response = await http.post(
        Uri.parse(api + 'api/auth/signin'),
        body: jsonEncode({
          "username": emailController.text,
          "password": passwordController.text,
        }),
        headers: {"content-type": "application/json"},
      );
      print(response.body);
      print(response.statusCode);
      print(response.headers);
      print(response.request);

      if (response.statusCode == 200) {
        setState(() {
          Map<String, dynamic> data =
              new Map<String, dynamic>.from(json.decode(response.body));
          String u_name = data['name'];
          String u_email = data['email'];
          String u_phone = data['phone'];
          //String u_image = data['img'];
          String tok = data['jwtCookie']['value'];
          print(u_phone);
          print("token = $tok");
          token = tok;
          username = u_name;
          // userimg = u_image;
        });
        Get.to(Dashboard());
      } else if (response.statusCode == 401) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            title: Text(
              "Wrong Email or Password",
              textAlign: TextAlign.center,
            ),
            // content: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text("Password needs atleast 8 characters",textAlign: TextAlign.center,),
            // ),
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

  void guestLogin() async {
    setLogin('guest');
    setState(() {
      username = "Guest";
    });

    Get.offAll(
      () => Dashboard(),
      transition: Transition.circularReveal,
      duration: Duration(milliseconds: 500),
    );
  }

  void getIp() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136

    setState(() {
      ip=ipv4;
      print(ip);
    });
    // The response type can be text, json or jsonp  117.193.168.171
  }

}
