import 'dart:convert';

import 'package:dtrip_login/home/ui/hotel/models/bookRoomModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../db/api.dart';
import '../../global.dart';

class RoomBookPage extends StatefulWidget {
  const RoomBookPage({Key? key, this.hotelCode, this.resultIndex, this.traceId, this.tokenId, this.hotelName, this.noOfRooms, this.hotelRoomDetails, this.night, this.checkin, this.checkout, this.categoryId}) : super(key: key);

  final hotelCode;
  final resultIndex;
  final traceId;
  final tokenId;
  final hotelName;
  final noOfRooms;
  final hotelRoomDetails;
  final night;
  final checkin;
  final checkout;
  final categoryId;



  @override
  State<RoomBookPage> createState() => _RoomBookPageState();
}
var selectedValue = "Mr";

class _RoomBookPageState extends State<RoomBookPage> {
  late BookRoomModel bookRoomModel = BookRoomModel("Mr","", "","","","",1,true,0,"","","");
 // List PrimaryGuests = [BookRoomModel("Mr", "", "").toJson()];
  List _hotelPassengers = [];
  List RoomPassenger = [];
int room = 3;
  @override
  void initState() {

    super.initState();
    for(var i = 0; i < widget.noOfRooms; i++){
      _hotelPassengers.add(BookRoomModel("Mr","", "","","","",1,true,0,"","","").toJson());
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(bottom: 30,left: 10),
          child: InkWell(
            onTap: () => Get.back(),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/icons/left-arrow.png'),
              radius: 15,
            ),
          ),
        ),
        toolbarHeight: 80,
        leadingWidth: 45,
        title: Text(
          "${widget.hotelName}",
          style: TextStyle(
              fontSize: 20,
              color: Colors.black
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.night} night",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "Price",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  Text(
                    "₹123561",
                    style: TextStyle(
                        fontFamily: "Metropolis",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff92278f)),
                  ),
                ],
              ),
            ),
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
                  bookNow();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "Book Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.width / 23,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    print(widget.hotelRoomDetails);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xAD9B9B9B),
                          offset: Offset(2, 3),
                          blurRadius: 5.0,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Column(
                               children: [
                                 Text(
                                   "CHECK-IN",
                                   style: TextStyle(
                                     fontSize: 14,
                                     color: Colors.black54,
                                     fontWeight: FontWeight.w600
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Text(
                                   "${widget.checkin}",
                                   style: TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.w900
                                   ),
                                 )
                               ],
                             ),
                             Column(
                               children: [
                                 Text(
                                   "${widget.night} night",
                                   style: TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w400
                                   ),
                                 )
                               ],
                             ),
                             Column(
                               children: [
                                 Text(
                                   "CHECK-OUT",
                                   style: TextStyle(
                                       fontSize: 14,
                                       color: Colors.black54,
                                       fontWeight: FontWeight.w600
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Text(
                                   "${widget.checkout}",
                                   style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.w900
                                   ),
                                 )
                               ],
                             ),
                           ],
                         ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text(
                                "${widget.noOfRooms} Rooms, ${GuestCount} Guest",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.purple
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                ListView.separated(
                  shrinkWrap: true,
                  reverse: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _hotelPassengers.length,
                  itemBuilder: (context, index) {

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xAD9B9B9B),
                            offset: Offset(2, 3),
                            blurRadius: 5.0,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print(_hotelPassengers[index]);
                              print(_hotelPassengers);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff92278f),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                              ),
                              padding: EdgeInsets.all(8),
                              height: 40,
                              child: Row(
                                children: [
                                  Text(
                                    "Room ${index + 1}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Primary Guest(Adult)",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: "Mr",
                                            groupValue: _hotelPassengers[index]['Title'],
                                            onChanged: (value) {
                                              print(value);
                                              setState(() {
                                               // selectedValue = value.toString();
                                                bookRoomModel.Title = value.toString();
                                                _hotelPassengers[index]['Title'] = value.toString();
                                              });
                                            },
                                        ),
                                        Text("Mr.")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: "Ms",
                                          groupValue: _hotelPassengers[index]['Title'],
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              //selectedValue = value.toString();
                                              bookRoomModel.Title = value.toString();
                                              _hotelPassengers[index]['Title'] = value.toString();
                                            });
                                          },
                                        ),
                                        Text("Ms.")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: "Mrs",
                                          groupValue: _hotelPassengers[index]['Title'],
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                             // selectedValue = value.toString();
                                              bookRoomModel.Title = value.toString();
                                              _hotelPassengers[index]['Title'] = value.toString();
                                            });
                                          },
                                        ),
                                        Text("Mrs.")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: "Miss",
                                          groupValue: _hotelPassengers[index]['Title'],
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              // selectedValue = value.toString();
                                              bookRoomModel.Title = value.toString();
                                              _hotelPassengers[index]['Title'] = value.toString();
                                            });
                                          },
                                        ),
                                        Text("Miss.")
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  color: Color(0x1292278f),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'First Name',
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        bookRoomModel.FirstName = value.toString();
                                        _hotelPassengers[index]['FirstName'] = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  color: Color(0x1292278f),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Middle Name',
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        bookRoomModel.FirstName = value.toString();
                                        _hotelPassengers[index]['MiddleName'] = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  color: Color(0x1292278f),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Last Name',
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        bookRoomModel.LastName = value.toString();
                                        _hotelPassengers[index]['LastName'] = value.toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 50,
                                  color: Color(0x1292278f),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone Number',
                                    ),
                                    onChanged: (value){
                                      setState(() {
                                        bookRoomModel.LastName = value.toString();
                                        _hotelPassengers[index]['Phoneno'] = value.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),



                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20,);
                },
                ),

                SizedBox(height: 30,),



              ],
            ),
          ),
        ),
      ),
    );
  }

  void bookNow() async {
    RoomPassenger.length >= widget.noOfRooms ? RoomPassenger.clear() : null;
    setState(() {
      for(var i = 0; i < widget.noOfRooms; i++){
       // hotelRoomDetail[i].add(_hotelPassengers[i]);
        List passenger = [_hotelPassengers[i]];
        hotelRoomDetail[i]['HotelPassenger'] = passenger;
        RoomPassenger.add(hotelRoomDetail[i]);


      }

    });
    print(RoomPassenger);
    print(RoomPassenger.length);



    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/book'),
      body: jsonEncode(
          {
            "EndUserIp": "$ips",
            "TokenId": "${widget.tokenId}",
            "TraceId": "${widget.traceId}",
            "AgencyId": 57222,
            "ResultIndex": "${widget.resultIndex}",
            "HotelCode": "${widget.hotelCode}",
            "CategoryId": "${widget.categoryId}",
            "HotelName": "${widget.hotelName}",
            "GuestNationality": "IN",
            "NoOfRooms": widget.noOfRooms,
            "IsVoucherBooking": true,
            "RoomDetails": RoomPassenger
          }
      ),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);


  }

}


