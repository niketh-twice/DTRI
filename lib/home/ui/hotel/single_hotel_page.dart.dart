import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Hotel/SingleHotelModel.dart';
import '../../../db/Hotel/hotelRoomDetails_model.dart';
import '../../../db/Hotel/hotel_model.dart';
import '../../../db/api.dart';
import '../../global.dart';
import 'BookingRoomSelection.dart';
import 'HotelGalleryPage.dart';
import 'package:http/http.dart' as http;

class SingleHotelPage extends StatefulWidget {
  const SingleHotelPage({Key? key, this.discription, this.rating, this.price, this.address, this.categoryId, this.picture, this.images, this.latitude, this.longitude, this.name, this.contact, this.hotelMap, this.hotelPolicy, this.hotelFacilities, this.night, this.checkout, this.checkin, this.hotelCode, this.traceId, this.resultIndex, this.categoryIndex, this.tokenId, }) : super(key: key);

  final discription;
  final rating;
  final price;
  final address;
  final categoryId;
  final picture;
  final images;
  final latitude;
  final longitude;
  final name;
  final contact;
  final hotelMap;
  final hotelPolicy;
  final hotelFacilities;
  final night;
  final checkout;
  final checkin;
  final hotelCode;
  final traceId;
  final resultIndex;
  final categoryIndex;
  final tokenId;


  @override
  State<SingleHotelPage> createState() => _SingleHotelPageState();
}




class _SingleHotelPageState extends State<SingleHotelPage> {
  List <HotelResult> searchResult = [];
  @override
  void initState() {

    super.initState();
    // GetRooms();
    print("discription:${widget.discription} ");
    print("address: ${widget.address}");
    print("contact : ${widget.contact}");
    print("Name : ${widget.name}");
    print("images: ${widget.images}");
    print("location: ${widget.latitude},${widget.longitude}");
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    List<Widget> imageSliders = imgList
        .map((item) => Container(
          child: Container(
        // margin: EdgeInsets.all(5.0),
           child: ClipRRect(
          // borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Text(
                      '${imgList.indexOf(item) + 1}/${imgList.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();


    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color(0xFFFFFFFF),
                  const Color(0xFFFFFFFF),
                ],
                begin: const FractionalOffset(1.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: InkWell(
                  onTap: () {

                    Navigator.pop(context);
                    setState(() {
                      imgList=[];
                      hotelFacilities=[];
                      //dispose();
                    });
                    },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/icons/left-arrow.png'),
                  radius: 15,
                ),
                //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20),
                  //   child: Container(
                  //     height: 50,
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Price",
                  //           style: TextStyle(
                  //               fontFamily: "Metropolis",
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.black54),
                  //         ),
                  //         Text(
                  //           "₹${widget.price}",
                  //           style: TextStyle(
                  //               fontFamily: "Metropolis",
                  //               fontSize: 20,
                  //               fontWeight: FontWeight.bold,
                  //               color: Color(0xff92278f)),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                        Get.to(BookRoomSelection(
                          hotelCode: widget.hotelCode,
                          resultIndex: widget.resultIndex,
                          traceId: widget.traceId,
                          tokenId: widget.tokenId,
                          night: widget.night,
                          checkin: widget.checkin,
                          checkout: widget.checkout,
                          hotelName: widget.name,
                          categoryId: widget.categoryId,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 20.0),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: StadiumBorder(),
                      ),
                      child: Text(
                        "Select rooms",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: orientation == "portrait"
                              ? screenSize.width / 23
                              : screenSize.height / 23,
                          fontFamily: 'Metropolis',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            imgList = widget.images;
                            hotelFacilities = widget.hotelFacilities;
                          });
                          Get.to(() =>HotelGallery(images: widget.images,));
                        },
                        child: CarouselSlider(
                          options: CarouselOptions(
                            clipBehavior: Clip.none,
                            aspectRatio: 2,
                            viewportFraction: 1.0,
                          ),
                          items: imageSliders,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffffffff),
                              offset: Offset(0, 5),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: screenSize.width / 1.5,
                                    child: Text(
                                      "${widget.name}",
                                      maxLines: 4,
                                      style: TextStyle(
                                        fontFamily: "Metropolis",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   child: IconButton(
                                  //       onPressed: () {},
                                  //       icon: Icon(
                                  //         Iconsax.heart5,
                                  //         size: 30,
                                  //         color: Colors.red,
                                  //       )),
                                  // )
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: widget.rating,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xfff04e6e),
                                    ),
                                    alignment: Alignment.center,
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 45,
                                      child: Text(
                                        "${widget.rating}",
                                        style: TextStyle(
                                            fontFamily: "Metropolis",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 10,),
                                  // Text(
                                  //   '',
                                  //   // widget.rating < 2 ? "Average": widget.rating == 3 ? "Good":widget.rating == 4 ? "Great" : widget.rating == 5? "Excellent" : "Okey",
                                  //   style: TextStyle(
                                  //       fontFamily: "Metropolis",
                                  //       fontWeight: FontWeight.bold,
                                  //       fontSize: 20,
                                  //       color: Colors.black),
                                  // ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Stack(children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        'assets/images/city-map.png',
                                      ),
                                    ),
                                  ),
                                  height: screenSize.height / 7,
                                ),
                                Container(
                                  height: screenSize.height / 7,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Color(0xffffffff),
                                      gradient: LinearGradient(
                                          begin: FractionalOffset.centerRight,
                                          end: FractionalOffset.center,
                                          colors: [
                                            Color(0xFFFFFF).withOpacity(0.0),
                                            Color(0xfff6f6f6),
                                          ],
                                          stops: [
                                            0.0,
                                            1.0
                                          ])),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30, top: 5),
                                              child: ReadMoreText(
                                                "${widget.address}",
                                                trimLines: 4,
                                                // colorClickableText: Colors.pink,
                                                style: TextStyle(
                                                    fontFamily: "Metropolis",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: ' Show more',
                                                trimExpandedText:
                                                    '   Show less',
                                                lessStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff92278f)),
                                                moreStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff92278f)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30, top: 5),
                                              child: ReadMoreText(
                                                "${widget.contact}",
                                                trimLines: 4,
                                                // colorClickableText: Colors.pink,
                                                style: TextStyle(
                                                    fontFamily: "Metropolis",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText: ' Show more',
                                                trimExpandedText:
                                                    '   Show less',
                                                lessStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff92278f)),
                                                moreStyle: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff92278f)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 40, bottom: 40, right: 20),
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                           widget.longitude == ""?null:
                                          await MapLauncher.showMarker(
                                            mapType: MapType.google,
                                            coords: Coords(double.parse(widget.latitude), double.parse(widget.longitude)),
                                            title: '${widget.name}',
                                          );
                                        },

                                        child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.transparent,
                                            child: Image.asset(
                                                'assets/images/icons/location.png')),
                                      ),
                                      Text(
                                        "MAP",
                                        style: TextStyle(
                                          fontFamily: "Metropolis",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Hotel Facilities",
                                  style: TextStyle(
                                    fontFamily: "Metropolis",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                height: 70,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hotelFacilities.length,
                                  itemBuilder:
                                      (BuildContext context, int index) => GestureDetector(
                                        onTap :(){
                                          print(hotelFacilities[index]);
                                          print(index);
                                          print(hotelFacilities);
                                          print(hotelFacilities.length);
                                          print(hotelFacilities[0]);
                                        },
                                        child: Card(
                                    elevation: 5,
                                    child: Center(
                                        child: Container(
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              "${hotelFacilities[index]}",
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ),
                                  ),
                                 ),
                                ),
                              ),

                              // Container(
                              //   alignment: Alignment.centerLeft,
                              //   child: Text(
                              //     "Hotel Facilities",
                              //     style: TextStyle(
                              //       fontFamily: "Metropolis",
                              //       fontSize: 16,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   height: 70,
                              //   child: ListView.builder(
                              //     shrinkWrap: true,
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: hotelFacilities.length,
                              //     itemBuilder:
                              //         (BuildContext context, int index) => Text(
                              //           "${hotelFacilities[index]}",
                              //           style: TextStyle(
                              //             fontFamily: "Metropolis",
                              //             fontSize: 14,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //   ),
                              // ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Check-in & Check-out",
                                          style: TextStyle(
                                              fontFamily: "Metropolis",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black45),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "${widget.checkin} - ${widget.checkout}",
                                          style: TextStyle(
                                              fontFamily: "Metropolis",
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${widget.night} night",
                                          style: TextStyle(
                                              fontFamily: "Metropolis",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black26,
                                    height: 50,
                                    width: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rooms & Guest",
                                          style: TextStyle(
                                              fontFamily: "Metropolis",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black45),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.door_front_door,
                                              color: Colors.black26,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${StoredGuest.length}",
                                              style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              Icons.people,
                                              color: Colors.black26,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${GuestCount}",
                                              style: TextStyle(
                                                fontFamily: "Metropolis",
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(5, 5),
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Discription",
                                style: TextStyle(
                                  fontFamily: "Metropolis",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  ReadMoreText(
                                    "${
                                      widget.discription.replaceAll(
                                          RegExp(r'<[^>]*>|&[^;]+;',
                                              multiLine: true,
                                              caseSensitive: true),
                                          '\n')
                                    }",
                                    trimLines: 8,
                                    // colorClickableText: Colors.pink,
                                    style: TextStyle(
                                        fontFamily: "Metropolis",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Colors.black54),
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: ' Show more',
                                    trimExpandedText: '   Show less',
                                    lessStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff92278f)),
                                    moreStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff92278f)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // void GetRooms() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var ips = prefs.getString('ip');
  //   final response = await http.post(
  //     Uri.parse(api + 'api/hotels/hotel-room'),
  //     body: jsonEncode({
  //       "HotelCode": widget.hotelCode,
  //       "ResultIndex": widget.resultIndex,
  //       "TraceId": widget.traceId,
  //       "TokenId": widget.tokenId,
  //       "EndUserIp": "$ips",
  //       // "CategoryId": widget.categoryIndex
  //     }),
  //     headers: {"content-type": "application/json"},
  //   );
  //   print(response.body);
  //   print(response.statusCode);
  //
  //   final result = hotelRoomsFromJson(response.body);
  //
  //   print("token : ${result}");
  //
  //
  //
  //
  // }

}
