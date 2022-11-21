import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../dashboard.dart';
import '../animation/fade_animation.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.landscape ? size.width : size.height,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        delay: 2.5,
                        child: Text(
                          "404",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:  orientation == "portrait" ? size.width/15 : size.height/15,
                            fontFamily: 'Metropolis',
                          ),
                        ),
                      ),

                      FadeAnimation(
                        delay: 2.0,
                        child: Text(
                          "Page Not Found!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: orientation == "portrait" ? size.width/17 : size.height/17,
                            fontFamily: 'Metropolis',
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Align(
                  alignment: Alignment.center,
                  child: FadeAnimation(
                    delay: 1.5,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: orientation == Orientation.landscape ? size.height : size.width,
                      height: orientation == Orientation.landscape ? size.width/2.5 : size.height/2.5,
                      child: Lottie.asset('assets/lottie/404-11.json', animate: true),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: FadeAnimation(
                    delay: 1,
                    child: Text(
                      "We\'re sorry, the page you requested\ncould not be found. Please go back\nto the homepage!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize:  orientation == "portrait" ? size.width/26 : size.height/26,
                        fontFamily: 'Metropolis',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10,top: 30),
                  child: FadeAnimation(
                    delay: 0.5,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: orientation == Orientation.landscape ? size.height/2 : size.width/2,
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
                            Get.to(Dashboard());
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            "GO HOME",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:  orientation == "portrait" ? size.width/38 : size.height/38,
                              fontFamily: 'Metropolis',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}