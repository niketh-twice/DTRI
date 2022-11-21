import 'package:dtrip_login/home/ui/flight/passengers_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../widgets/widgets.dart';
import 'flight_list_page.dart';

class FlightBook extends StatefulWidget {
  const FlightBook({super.key});

  @override
  State<FlightBook> createState() => _FlightBookState();
}

class _FlightBookState extends State<FlightBook> {
  var btn1 = "active", btn2 = "", btn3 = "";

  var fromPlace = "Bengaluru";
  var fromPort = "Bengaluru International Airport";
  var toPlace = "New Delhi";
  var toPort = "Indra Gandhi International Airport";

  late DateTime _dateTime;
  var initialDate = DateTime.now();
  var retDate;
  var arrDate;

  var departureDate =
      DateFormat('dd MMM, yyyy').format(DateTime.now()).toString();
  var returnDate = DateFormat('dd MMM, yyyy')
      .format(DateTime.now()).toString();

  @override
  void initState() {
    print(passengers);
    super.initState();
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Find Your Flight",
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/13 : screenSize.height/13,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: Container(
                                  width: orientation == "portrait" ? screenSize.width / 2.5 : screenSize.height / 2.5,
                                  child: Lottie.asset(
                                      'assets/lottie/flight-ticket.json',
                                      fit: BoxFit.contain)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Color(0xffffffff), Color(0xffffffff)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFE9D4E9),
                                blurRadius: 5.0,
                                spreadRadius: 2,
                                offset: Offset(
                                  2,
                                  3,
                                ),
                              )
                            ],
                            //color: Colors.blue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      btn1 = "active";
                                      btn2 = "";
                                      btn3 = "";
                                    });
                                  },
                                  child: Text(
                                    "ONE-WAY",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: btn1 == "active"
                                            ? Color(0xff92278f)
                                            : Color(0xffb2a1b8),
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      btn1 = "";
                                      btn2 = "active";
                                      btn3 = "";
                                    });
                                  },
                                  child: Text(
                                    "ROUND TRIP",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: btn2 == "active"
                                            ? Color(0xff92278f)
                                            : Color(0xffb2a1b8),
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      btn1 = "";
                                      btn2 = "";
                                      btn3 = "active";
                                    });
                                  },
                                  child: Text(
                                    "MULTICITY",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: btn3 == "active"
                                            ? Color(0xff92278f)
                                            : Color(0xffb2a1b8),
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          //color: Color(0x8bffffff),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(FlightListPage());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/departure.png')),
                                  title: Text(
                                    "${fromPlace}",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Departure",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 1,
                                    width: screenSize.width / 1.54,
                                    color: Colors.black26,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        print("swap click");
                                        var temp;
                                        var port;
                                        temp = toPlace;
                                        toPlace = fromPlace;
                                        fromPlace = temp;
                                      });
                                      print("to place: $toPlace");
                                      print("from place: $fromPlace");
                                    },
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.grey,
                                      child: CircleAvatar(
                                        radius: 20,
                                        foregroundColor: Colors.black,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                            radius: 18,
                                            backgroundColor: Colors.transparent,
                                            child: Image.asset(
                                                'assets/images/icons/sort.png')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(FlightListPage());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/arrival.png')),
                                  title: Text(
                                    "${toPlace}",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Destination",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 1,
                                    width: screenSize.width / 1.3,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var datePicker = await showDatePicker(
                                    context: context,
                                    initialDate: initialDate,
                                    firstDate: initialDate,
                                    lastDate: DateTime(2099),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          primaryColor: const Color(0xFF92278F),
                                          // accentColor: const Color(0xFF879AE9),
                                          colorScheme: ColorScheme.light(
                                              primary: const Color(0xFF92278F)),
                                          dialogTheme: const DialogTheme(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              18)))),
                                          buttonTheme: ButtonThemeData(
                                              textTheme:
                                                  ButtonTextTheme.primary),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  _dateTime = datePicker!;
                                  var formatter =
                                      new DateFormat('dd MMM, yyyy');
                                  String date = formatter.format(_dateTime);
                                  setState(() {
                                    print(_dateTime);
                                    retDate = _dateTime;
                                    arrDate = _dateTime;
                                    print(DateTime.now());
                                    departureDate = date;
                                    returnDate = date;
                                    print(date);
                                  });
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/calendar.png')),
                                  title: Text(
                                    "${departureDate}",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Departure Date",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              btn2 == "active"
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 1,
                                          width: screenSize.width / 1.3,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    )
                                  : Container(),
                              btn2 == "active"
                                  ? GestureDetector(
                                      onTap: () async {

                                        var datePicker = await showDatePicker(
                                          context: context,
                                          initialDate: retDate,
                                          firstDate: retDate,
                                          lastDate: DateTime(2099),
                                          builder: (context, child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor:
                                                    const Color(0xFF92278F),
                                                // accentColor: const Color(0xFF879AE9),
                                                colorScheme: ColorScheme.light(
                                                    primary: const Color(
                                                        0xFF92278F)),
                                                dialogTheme: const DialogTheme(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    18)))),
                                                buttonTheme: ButtonThemeData(
                                                    textTheme: ButtonTextTheme
                                                        .primary),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        );
                                        _dateTime = datePicker!;
                                        var formatter =
                                            new DateFormat('dd MMM, yyyy');
                                        String date =
                                            formatter.format(_dateTime);
                                        setState(() {
                                          print(_dateTime);
                                          print(DateTime.now());
                                          returnDate = date;
                                          print(date);
                                        });
                                      },
                                      child: ListTile(
                                        leading: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.transparent,
                                            child: Image.asset(
                                                'assets/images/icons/schedule.png')),
                                        title: Text(
                                          "${returnDate}",
                                          style: TextStyle(
                                              fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                              fontFamily: 'Metropolis',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "Arraival Date",
                                          style: TextStyle(
                                              fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                              fontFamily: 'Metropolis',
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 1,
                                    width: screenSize.width / 1.3,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(PassengerSelectionPage());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/group.png')),
                                  title: Text(
                                    "${passengers}",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Passengers",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 1,
                                    width: screenSize.width / 1.3,
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(PassengerSelectionPage());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.transparent,
                                      child: Image.asset(
                                          'assets/images/icons/first-class.png')),
                                  title: Text(
                                    "${planeClassName}",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Cabin Class",
                                    style: TextStyle(
                                        fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                        fontFamily: 'Metropolis',
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFE9D4E9),
                                      offset: Offset(2, 3),
                                      blurRadius: 5.0,
                                  spreadRadius: 2,
                                  ),
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
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40.0, vertical: 20.0),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: StadiumBorder(),
                                ),
                                child: Text(
                                  "Search Flight",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                    fontFamily: 'Metropolis',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
