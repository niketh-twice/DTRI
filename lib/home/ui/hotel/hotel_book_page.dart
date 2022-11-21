import 'dart:convert';
import 'package:dtrip_login/home/ui/hotel/rooms_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../../widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'hotel_places_page.dart';
import 'hotel_result.dart';
import 'package:map_launcher/map_launcher.dart';



class HotelBook extends StatefulWidget {
  const HotelBook({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<HotelBook> createState() => _HotelBookState();
}

class _HotelBookState extends State<HotelBook> with RestorationMixin {

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTimeN _startDate = RestorableDateTimeN(DateTime.now());
  final RestorableDateTimeN _endDate =
  RestorableDateTimeN(DateTime.now().add(Duration(days: 1)));
  late final RestorableRouteFuture<DateTimeRange?>
  _restorableDateRangePickerRouteFuture =
  RestorableRouteFuture<DateTimeRange?>(
    onComplete: _selectDateRange,
    onPresent: (NavigatorState navigator, Object? arguments) {
      setState(() {

      });
      return navigator
          .restorablePush(_dateRangePickerRoute, arguments: <String, dynamic>{
        'initialStartDate': _startDate.value?.millisecondsSinceEpoch,
        'initialEndDate': _endDate.value?.millisecondsSinceEpoch,
      });


    },
  );

  void _selectDateRange(DateTimeRange? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _startDate.value = newSelectedDate.start;
        _endDate.value = newSelectedDate.end;

        print(_startDate.value);
        print(_endDate.value);

        inDate =  DateFormat('dd MMM').format(_startDate.value as DateTime);
        outDate =  DateFormat('dd MMM').format(_endDate.value as DateTime);

        chechinDate = DateFormat('yyyy-MM-dd').format(_startDate.value as DateTime).toString();
        checkOutDate = DateFormat('yyyy-MM-dd').format(_endDate.value as DateTime).toString();

        passDate1 = DateFormat('dd MMM').format(_startDate.value as DateTime).toString();
        passDate2 = DateFormat('dd MMM').format(_endDate.value as DateTime).toString();

        var day1 = _startDate.value as DateTime;
        var day2 = _endDate.value as DateTime;
        night = day2.difference(day1).inDays;
      });
    }
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_startDate, 'start_date');
    registerForRestoration(_endDate, 'end_date');
    registerForRestoration(
        _restorableDateRangePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTimeRange?> _dateRangePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTimeRange?>(
      context: context,
      builder: (BuildContext context) {
        return DateRangePickerDialog(
          restorationId: 'date_picker_dialog',
          initialDateRange:
          _initialDateTimeRange(arguments! as Map<dynamic, dynamic>),
          firstDate: DateTime.now(),
          currentDate: DateTime.now(),
          lastDate: DateTime(2099),
        );
      },
    );
  }

  static DateTimeRange? _initialDateTimeRange(Map<dynamic, dynamic> arguments) {
    if (arguments['initialStartDate'] != null &&
        arguments['initialEndDate'] != null) {
      return DateTimeRange(
        start: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialStartDate'] as int),
        end: DateTime.fromMillisecondsSinceEpoch(
            arguments['initialEndDate'] as int),
      );
    }

    return null;
  }


//................................................................................................

  // late DateTime _dateTime;
  // var initialDate = DateTime.now();
  // var retDate = DateTime.now().add(Duration(days: 1));


  var chechinDate =
  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  var checkOutDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(Duration(days: 1))).toString();

  var inDate = DateFormat('dd MMM').format(DateTime.now()).toString();
  var outDate = DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 1))).toString();

  var night = 1;

  var passDate1 = DateFormat('dd MMM').format(DateTime.now()).toString();
  var passDate2 = DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 1))).toString();


  @override
  void initState() {

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
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Find Your Hotel",
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/14 : screenSize.height/14,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  print(chechinDate);
                                  print(checkOutDate);
                                  print(inDate);
                                  print(outDate);
                                  print(passDate1);
                                  print(passDate2);
                                  print(night);

                                },
                                child: Container(
                                    width:orientation == "portrait" ? screenSize.width/6 : screenSize.height/6,
                                    child: Lottie.asset(
                                        'assets/lottie/hotel-bell.json',
                                        fit: BoxFit.contain)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                        //color: Color(0x8bffffff),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(HotelPlacesPage());
                               // Get.to(DetailsPage());
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/hotel3.png')),
                                title: Text(
                                  city==""?"Place":"$city",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  country==""?"Country" :"$country",
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
                              onTap: ()  {
                                _restorableDateRangePickerRouteFuture.present();

                                // var datePicker = await showDatePicker(
                                //   context: context,
                                //   initialDate: initialDate,
                                //   firstDate: initialDate,
                                //   lastDate: DateTime(2099),
                                //   builder: (context, child) {
                                //     return Theme(
                                //       data: ThemeData.light().copyWith(
                                //         primaryColor: const Color(0xFF92278F),
                                //         // accentColor: const Color(0xFF879AE9),
                                //         colorScheme: ColorScheme.light(
                                //             primary: const Color(0xFF92278F)),
                                //         dialogTheme: const DialogTheme(
                                //             shape: RoundedRectangleBorder(
                                //                 borderRadius:
                                //                 BorderRadius.all(
                                //                     Radius.circular(
                                //                         18)))),
                                //         buttonTheme: ButtonThemeData(
                                //             textTheme:
                                //             ButtonTextTheme.primary),
                                //       ),
                                //       child: child!,
                                //     );
                                //   },
                                // );
                                // _dateTime = datePicker!;
                                // var formatter =
                                // new DateFormat('yyyy-MM-dd');
                                // String date = formatter.format(_dateTime);
                                // String out =
                                // formatter.format(_dateTime.add(Duration(days: 1)));
                                //
                                // var displayDate = new DateFormat('dd MMM, yyyy');
                                // String printDate = displayDate.format(_dateTime);
                                // String otDate = displayDate.format(_dateTime.add(Duration(days: 1)));
                                //
                                // var checkin = new DateFormat('dd MMM');
                                // String prDate = checkin.format(_dateTime);
                                // print(prDate);
                                //
                                // setState(() {
                                //   passDate1 = prDate;
                                //   print(_dateTime);
                                //   retDate = _dateTime.add(Duration(days: 1));
                                //   inday = _dateTime;
                                //   inDate = printDate;
                                //   outDate = otDate;
                                //   print(DateTime.now());
                                //   chechinDate = date;
                                //   checkOutDate = out;
                                //   print(date);
                                // });
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/calendar.png')),
                                title: Text(
                                  "${inDate} - ${outDate}",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Checkin & Checkout",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Container(
                            //       height: 1,
                            //       width: screenSize.width / 1.3,
                            //       color: Colors.black26,
                            //     ),
                            //   ],
                            // ),
                            //  GestureDetector(
                            //   onTap: ()  {
                            //     _restorableDateRangePickerRouteFuture.present();
                            //
                            //     // var datePicker = await showDatePicker(
                            //     //   context: context,
                            //     //   initialDate: retDate,
                            //     //   firstDate: retDate,
                            //     //   lastDate: DateTime(2099),
                            //     //   builder: (context, child) {
                            //     //     return Theme(
                            //     //       data: ThemeData.light().copyWith(
                            //     //         primaryColor:
                            //     //         const Color(0xFF92278F),
                            //     //         // accentColor: const Color(0xFF879AE9),
                            //     //         colorScheme: ColorScheme.light(
                            //     //             primary: const Color(
                            //     //                 0xFF92278F)),
                            //     //         dialogTheme: const DialogTheme(
                            //     //             shape: RoundedRectangleBorder(
                            //     //                 borderRadius:
                            //     //                 BorderRadius.all(
                            //     //                     Radius.circular(
                            //     //                         18)))),
                            //     //         buttonTheme: ButtonThemeData(
                            //     //             textTheme: ButtonTextTheme
                            //     //                 .primary),
                            //     //       ),
                            //     //
                            //     //       child: child!,
                            //     //     );
                            //     //   },
                            //     // );
                            //     // _dateTime = datePicker!;
                            //     // var formatter =
                            //     // new DateFormat('yyyy-MM-dd');
                            //     // String date =
                            //     // formatter.format(_dateTime);
                            //     //
                            //     // var displayDate = new DateFormat('dd MMM, yyyy');
                            //     // String printDate = displayDate.format(_dateTime);
                            //     //
                            //     // var checkin = new DateFormat('dd MMM');
                            //     // String prDate = checkin.format(_dateTime);
                            //     // print(prDate);
                            //     //
                            //     // setState(() {
                            //     //   passDate2 = prDate;
                            //     //   print(_dateTime);
                            //     //   outday = _dateTime;
                            //     //   outDate = printDate;
                            //     //   print(printDate);
                            //     //   print(DateTime.now());
                            //     //   checkOutDate = date;
                            //     //   print(date);
                            //     //   final difference = outday.difference(inday).inDays;
                            //     //   print(difference);
                            //     //   night = difference;
                            //     //   print(inday);
                            //     // });
                            //   },
                            //   child: ListTile(
                            //     leading: CircleAvatar(
                            //         radius: 20,
                            //         backgroundColor: Colors.transparent,
                            //         child: Image.asset(
                            //             'assets/images/icons/schedule.png')),
                            //     title: Text(
                            //       "${outDate}",
                            //       style: TextStyle(
                            //           fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                            //           fontFamily: 'Metropolis',
                            //           color: Colors.black,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     subtitle: Text(
                            //       "Checkout Date",
                            //       style: TextStyle(
                            //           fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                            //           fontFamily: 'Metropolis',
                            //           color: Colors.black54,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // ),
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
                                Get.to(RoomSelectionPage());
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset(
                                        'assets/images/icons/group.png')),
                                title: Text(
                                  "${room}",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Rooms",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
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
                                    onPressed: () {
                                      if(city == ""){
                                        //notify to choose place
                                        print("choose a place");
                                      }else{
                                        Get.to(HotelResultPage(cityId: cityId,countryCode: countryCode,night: night,checkinDate: chechinDate,checkoutDate: checkOutDate,inDate: passDate1,outdate: passDate2,));
                                      }

                                      print(chechinDate);
                                      print(night);
                                      // searchHotel();

                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40.0, vertical: 20.0),
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: StadiumBorder(),
                                    ),
                                    child: Text(
                                      "Search Hotel",
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
                              height: 20,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 50,
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
