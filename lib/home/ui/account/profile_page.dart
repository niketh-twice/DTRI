import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:dtrip_login/home/constant.dart';
import 'package:dtrip_login/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:icon_badge/icon_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Shared/SharedPrefs.dart';
import '../../../db/api.dart';
import '../../../login/login_controller.dart';
import '../../../login/login_page.dart';

import '../errors/view/error-404.dart';
import 'edit_profile_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}
var name;
var email;
var loginMethod;

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    print('username = ' + username);

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(255, 255, 255, 1.0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   top: -250,
          //   left: -40,
          //   child: topWidget(screenSize.width),
          // ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 20, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  print('click');
                                  // username=="Guest"?Get.to(LoginPage()):print('notifications');
                                  loginMethod == null || loginMethod == 'guest' ?
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Text(
                                              "Not a user?",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                              "Login or Create an account to get more features and access our exclusive deals and offers.",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('Cancel',
                                                style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.to(LoginPage());
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ) : print('notifications');
                                },
                                child: Badge(
                                    badgeContent: Text(
                                      '3',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    badgeColor: Colors.red,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                        "assets/images/icons/bell.png",
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                       CircleAvatar(
                                          radius: 65,
                                          backgroundColor: Colors.black12,
                                          child: CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.white,
                                            child: Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      // : CircleAvatar(
                                      //     radius: 65,
                                      //     backgroundColor: Colors.black12,
                                      //     child: CircleAvatar(
                                      //       radius: 60,
                                      //       backgroundColor: Colors.white,
                                      //       backgroundImage: NetworkImage(
                                      //         '$userimg',
                                      //       ),
                                      //     ),
                                      //   ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    loginMethod == null || loginMethod == 'guest' ? "Guest":"$name",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/15 : screenSize.height/15,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 50,
                              width: screenSize.width / 2.5,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffece8ed),
                                      Color(0xffece8ed)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFE9D4E9),
                                      offset: Offset(2, 3),
                                      blurRadius: 5.0,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            side: BorderSide.none))),
                                onPressed: () {
                                  loginMethod == 'guest'? showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Text(
                                            "Not a user?",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                            "Login or Create an account to get more features and access our exclusive deals and offers.",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('Cancel',
                                                style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.to(LoginPage());
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ):print('bookings');
                                },
                                child: Text(
                                  "My Bookings",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: screenSize.width / 2.5,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffece8ed),
                                      Color(0xffece8ed)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFE9D4E9),
                                      offset: Offset(2, 3),
                                      blurRadius: 5.0,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.transparent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            side: BorderSide.none))),
                                onPressed: () {
                                  loginMethod == null || loginMethod == 'guest' ? showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          title: Text(
                                            "Not a user?",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: Text(
                                            "Login or Create an account to get more features and access our exclusive deals and offers.",
                                            style: TextStyle(
                                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                                fontFamily: 'Metropolis',
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('Cancel',
                                                style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.to(LoginPage());
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                  ):print('favourites');
                                },
                                child: Text(
                                  "Favourites",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Account Settings",
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/17 : screenSize.height/17,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            print('Edit Profile');
                            loginMethod == null || loginMethod == 'guest' ? showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    title: Text(
                                      "Not a user?",
                                      style: TextStyle(
                                          fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      "Login or Create an account to get more features and access our exclusive deals and offers.",
                                      style: TextStyle(
                                          fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancel',
                                          style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(LoginPage());
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                            ):Get.to(EditProfilePage());

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/profile-settings.png'),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            print('Notification Srttings');

                            loginMethod == null || loginMethod == 'guest' ? showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                    title: Text(
                                      "Not a user?",
                                      style: TextStyle(
                                          fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(
                                      "Login or Create an account to get more features and access our exclusive deals and offers.",
                                      style: TextStyle(
                                          fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                          fontFamily: 'Metropolis',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: const Text('Cancel',
                                          style: TextStyle(color: Colors.black54, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(LoginPage());
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(color: Colors.purple, fontFamily: 'Metropolis',fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                            ):print('notification Settings');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/notification-settings.png'),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Notification Settings",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "App Settings",
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/17 : screenSize.height/17,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            print('App Settings');

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/settings1.png'),
                                    radius: 15,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Settings",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                image: new DecorationImage(
                                  image: AssetImage(
                                      "assets/images/dtrips_logo_dark.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            loginMethod == null || loginMethod == 'guest' ? Container(
                    child: Column(
                      children: [
                        Text(
                            "Join us to explore more & Get exclusive deals and offers.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 20,),
                        OutlinedButton(
                          onPressed: () {
                            Get.to(LoginPage());
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color(0xfff4e9f4)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(30.0)),
                            ),
                          ),
                          child: Text(
                            "Join Us",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                                fontFamily: 'Metropolis',
                                color: Color(0xff92278f),
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                      ],
                    ),
                  ): Container(
                              child: OutlinedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                      title: Text("Are you sure?"),
                                      content: Text("Do you want to logout?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          child: const Text('Cancel',
                                              style: TextStyle(
                                                  color: Color(0xff7f91dd))),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            logout();

                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xfff4e9f4)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                  ),
                                ),
                                child: Text(
                                  "Log Out",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                                      fontFamily: 'Metropolis',
                                      color: Color(0xff92278f),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() async {
    GoogleSignInApi.logout();
    removeName();
    removeJwt();
    removeEmail();
    removeLogin();
    setState(() {

      userimg = '';
      username = '';
      token = '';
    });
    Get.offAll(LoginPage());
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     name =  prefs.get('name').toString();
     email = prefs.get('email').toString();
     loginMethod = prefs.get('login');
    });


  }
}
