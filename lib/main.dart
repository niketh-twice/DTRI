import 'package:dart_ipify/dart_ipify.dart';
import 'package:dtrip_login/home/ui/hotel/bookRoomDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/global.dart';
import 'home/onboarding/onboarding.dart';
import 'home/onboarding/onboarding_page.dart';
import 'home/ui/home/search_page.dart';
import 'home/ui/hotel/BookingRoomSelection.dart';
import 'home/ui/hotel/single_hotel_page.dart.dart';
import 'login/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
   getIp();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          //color set to transperent or set your own color
          statusBarIconBrightness: Brightness.dark,
          //set brightness for icons, like dark background light icons
        )
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home:
        //RoomBookPage(),
      OnboardingPage(),
    );
  }

  void getIp() async {
    final ipv4 = await Ipify.ipv4();
    print(ipv4); // 98.207.254.136
    setState(()  {
      setIp(ipv4);
      ip=ipv4;
      print(ip);
    });
    // The response type can be text, json or jsonp  117.193.168.171
  }
  void setIp(String ipv4) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ipv4);
  }
}
