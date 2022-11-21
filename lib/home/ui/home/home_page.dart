import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dtrip_login/home/ui/home/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/api.dart';
import '../../constant.dart';
import '../../global.dart';
import '../../items.dart';
import '../../widgets/widgets.dart';
import 'package:http/http.dart' as http;

import '../hotel/hotel_book_page.dart';
import '../hotel/hotel_places_page.dart';
import '../hotel/hotel_result.dart';
import '../hotel/rooms_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin{
  int _currentIndex = 0;
  bool isLoading = true;
  List cardList = [
    Item1(),
    Item2(),
    Item3(),
    Item4(),
    Item5(),
    Item6(),
    Item7()
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  //...............................................................................

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


  var chechinDate =
  DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
  var checkOutDate = DateFormat('yyyy-MM-dd')
      .format(DateTime.now().add(Duration(days: 1))).toString();

  var inDate = DateFormat('dd MMM').format(DateTime.now()).toString();
  var outDate = DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 1))).toString();

  var night = 1;

  var passDate1 = DateFormat('dd MMM').format(DateTime.now()).toString();
  var passDate2 = DateFormat('dd MMM').format(DateTime.now().add(Duration(days: 1))).toString();

  //.............................................................................


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

          // Positioned(
          //
          //     child: Container(
          //       decoration: BoxDecoration(
          //         //color: Colors.blue,
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(0),
          //             bottomRight: Radius.circular(100.0),
          //             topLeft: Radius.circular(0),
          //             bottomLeft: Radius.circular(100.0)),
          //       ),
          //       height: 140,
          //       width: screenSize.width,
          //       child:Lottie.asset(
          //         'assets/lottie/Snow.json',
          //         alignment: Alignment.topCenter,
          //       ),
          //     )),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //         decoration: BoxDecoration(
                    //           color: Color(0xff92278f),
                    //           borderRadius: BorderRadius.only(
                    //               topRight: Radius.circular(0),
                    //               bottomRight: Radius.circular(50.0),
                    //               topLeft: Radius.circular(0),
                    //               bottomLeft: Radius.circular(50.0)),
                    //         ),
                    //   child: Stack(
                    //     children: [
                    //   //   Container(
                    //   //     height: 100,
                    //   //     width: screenSize.width,
                    //   //     child: Lottie.asset(
                    //   //     'assets/lottie/Snow.json',
                    //   //     alignment: Alignment.topCenter,
                    //   // ),
                    //   //   ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 20,bottom: 10),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: [
                    //             InkWell(
                    //               onTap: (){
                    //                 print("hotel");
                    //                 print(orientation);
                    //                 print(screenSize.height);
                    //
                    //               },
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   CircleAvatar(
                    //                     radius: 25,
                    //                     backgroundColor: Colors.transparent,
                    //                     child: Image.asset(
                    //                         'assets/images/icons/hotel2.png'),
                    //                   ),
                    //                   Container(
                    //                     alignment: Alignment.center,
                    //                     child: Text(
                    //                       "Hotel",
                    //                       style: TextStyle(
                    //                           fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                    //                           fontFamily: 'Metropolis',
                    //                           color: Colors.white,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap: (){
                    //                 print("plane");
                    //               },
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                    //                 children: [
                    //                   CircleAvatar(
                    //                     radius: 25,
                    //                     backgroundColor: Colors.transparent,
                    //                     child: Image.asset(
                    //                         'assets/images/icons/airplane1.png'),
                    //                   ),
                    //                   Container(
                    //                     alignment: Alignment.center,
                    //                     child: Text(
                    //                       "Flight",
                    //                       style: TextStyle(
                    //                           fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                    //                           fontFamily: 'Metropolis',
                    //                           color: Colors.white,
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    //........................................................


                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
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
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  var ips = prefs.getString('ip');
                                  print("ip : $ips");

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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
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
                    ),


                    //........................................................
                    SizedBox(
                      height: 30,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                    'assets/images/icons/airplane1.png'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Flight",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                    'assets/images/icons/compass.png'),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Explore",
                                  style: TextStyle(
                                      fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                      fontFamily: 'Metropolis',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 25,
                          //       backgroundColor: Colors.white,
                          //       child: Image.asset(
                          //           'assets/images/icons/discount.png'),
                          //     ),
                          //     Container(
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         "Offers",
                          //         style: TextStyle(
                          //             fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                          //             fontFamily: 'Metropolis',
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.w400),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 25,
                          //       backgroundColor: Colors.white,
                          //       child: Image.asset(
                          //           'assets/images/icons/place.png'),
                          //     ),
                          //     Container(
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         "Places",
                          //         style: TextStyle(
                          //             fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                          //             fontFamily: 'Metropolis',
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.w400),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 25,
                          //       backgroundColor: Colors.white,
                          //       child: Image.asset(
                          //           'assets/images/icons/nearby.png'),
                          //     ),
                          //     Container(
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         "Nearby",
                          //         style: TextStyle(
                          //             fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                          //             fontFamily: 'Metropolis',
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.w400),
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 170,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.linear,
                          pauseAutoPlayOnTouch: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: cardList.map((card) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              height:
                                  170,
                              width: 390,
                              child: InkWell(
                                onTap: () {
                                  print(_currentIndex);
                                },
                                child: Container(
                                  child: card,
                                ),
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: map<Widget>(cardList, (index, url) {
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Color(0xff92278f)
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Popular Places",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                fontFamily: 'Metropolis',
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hotDestination.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 10 : 0),
                                  child: hotDestinationCard(
                                      hotDestination[index]['imagePath']!,
                                      hotDestination[index]['placeName']!,
                                      hotDestination[index]['placeCount']!,
                                      context),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Hotels",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                fontFamily: 'Metropolis',
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.black54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: topHotels.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 10 : 0),
                                  child: hotDestinationCard(
                                      topHotels[index]['imagePath']!,
                                      topHotels[index]['placeName']!,
                                      topHotels[index]['hotelCount']!,
                                      context),
                                )),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



}
