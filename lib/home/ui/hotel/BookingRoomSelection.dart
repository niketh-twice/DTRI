import 'dart:convert';
import 'package:dtrip_login/home/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:supercharged/supercharged.dart';
import '../../../db/Hotel/hotelRoomDetails_model.dart';
import '../../../db/api.dart';
import 'bookRoomDetailsPage.dart';
import 'models/bookRoomModel.dart';

class BookRoomSelection extends StatefulWidget {
  const BookRoomSelection({Key? key, this.hotelCode, this.resultIndex, this.traceId, this.tokenId, this.hotelName, this.night, this.checkin, this.checkout, this.categoryId}) : super(key: key);
  final hotelCode;
  final resultIndex;
  final traceId;
  final tokenId;
  final hotelName;
  final night;
  final checkin;
  final checkout;
  final categoryId;

  @override
  State<BookRoomSelection> createState() => _BookRoomSelectionState();

}
List <HotelRoomsDetail>hotelRoomDetails = [];
List roomCombinationsArray = [];
List  details = [];
List selectedRooms = [];

// late BlockRoomSelection blockRoomSelection = BlockRoomSelection(
//   resultIndex: null,
//   hotelCode: null,
//   hotelName: null,
//   guestNationality: null,
//   noOfRooms: null,
//   clientReferenceNo: null,
//   isVoucherBooking: null,
//   categoryId: null,
//   endUserIp: null,
//   tokenId: null,
//   traceId: null,
//   hotelRoomsDetails: [],
// );
// int detailsCount = 0;

class _BookRoomSelectionState extends State<BookRoomSelection> {

  // late BlockRoomModel blockRoomModel = BlockRoomModel(widget.resultIndex, widget.hotelCode, widget.hotelName, '', '', 0, '', '', '', widget.tokenId, widget.traceId, []);

  @override
  void initState() {

    super.initState();
    GetRooms();
  }

  Set active = {};

  void _handleTap(index) {
    setState(() {
      active.contains(index) ? active.remove(index) : active.add(index);
      print("................");

    });
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton:  hotelRoomDetails.isEmpty? null : Padding(
        padding: const EdgeInsets.only(top: 5),
        child: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset('assets/images/icons/left-arrow.png'),
            radius: 15,
          ),
          //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
        ),
      ),
      bottomNavigationBar:hotelRoomDetails.isEmpty?null : Padding(
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
            //           "₹123561",
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
                  print('reserve now');
                  active.length > StoredGuest.length||active.length < StoredGuest.length ? showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Room Mismatch'),
                      content: const Text('No of rooms you selected is different from your search '),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ) :
                  reserveRooms();

                  // apiCall();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: StadiumBorder(),
                ),
                child: Text(
                  "Reserve Now",
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
        child: hotelRoomDetails.isEmpty?
        Center(child: Container(
            child: Lottie.asset(
                'assets/lottie/loading.json',
                fit: BoxFit.contain)),)
        :SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Choose your room",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      reverse: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: hotelRoomDetails.length,
                      itemBuilder: (context, index) {

                        return Container(
                          decoration: BoxDecoration(
                            boxShadow:  [
                              BoxShadow(
                                  color: Colors.black45,
                                  offset: Offset(2, 2),
                                  blurRadius: 5.0)
                            ],
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                Color(0xffffffff),
                                Color(0xffffffff),
                              ],
                            ),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${hotelRoomDetails[index].roomTypeName}",
                                        maxLines: 3,
                                        style: TextStyle(

                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.purple
                                        ),
                                      ),
                                    ),
                                   // Icon(Icons.info_outline,size: 30,color: Colors.purple,),
                                  ],
                                ),
                                // SizedBox(height: 10,),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Price for:",
                                //       style: TextStyle(
                                //         fontSize: 12,
                                //       ),
                                //     ),
                                //     SizedBox(width: 10,),
                                //
                                //     Icon(Icons.person_outline,size: 20,),
                                //     Icon(Icons.person_outline,size: 20,),
                                //   ],
                                // ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.meeting_room_outlined,size: 20,),
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Text(
                                        // "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                                        "${hotelRoomDetails[index].roomDescription}",
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 14
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 10,),
                                // Row(
                                //   children: [
                                //     Text(
                                //       "Size: 150 ft²",
                                //       style: TextStyle(
                                //         fontSize: 12,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 10,),

                                ListView.builder(
                                itemCount: hotelRoomDetails[index].amenities!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext ctxt, int Index) {
                                  return Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle,size: 18,color: Colors.green,),
                                        SizedBox(width: 10,),
                                        Text(
                                           "${hotelRoomDetails[index].amenities![Index]}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            color: Colors.green
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                ),

                                  FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Icon(Icons.book_outlined,size: 20),
                                      SizedBox(width: 10,),
                                      Text(
                                        hotelRoomDetails[index].isPassportMandatory==true ?"Passport needed" : "No passport needed",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Icon(Icons.credit_card,size: 20,),
                                      SizedBox(width: 10,),
                                      Text(
                                        hotelRoomDetails[index].isPanMandatory==true ?"Pan-Card needed" : "No pan-card needed",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,size: 20,),
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Text(
                                        "Last Cancellation date: ${hotelRoomDetails[index].lastCancellationDate}",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 14,
                                            //color: Colors.green,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Wrap(
                                            children: <Widget>[
                                              Center(
                                                  child: Container(
                                                      height: 4.0, width: 50.0, color: Color(0xFF32335C))),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                             Column(
                                               children: [
                                                  ListView.builder(
                                                  itemCount: hotelRoomDetails[index].cancellationPolicies!.length,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (BuildContext ctxt, int Index) {
                                                  return Container(
                                                    padding: EdgeInsets.only(bottom: 10),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons.circle,size: 18,),
                                                            SizedBox(width: 10,),
                                                            Text(
                                                              "Charge: ${hotelRoomDetails[index].cancellationPolicies![Index].charge}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.green
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        // Row(
                                                        //   children: [
                                                        //     Icon(Icons.circle,size: 18,),
                                                        //     SizedBox(width: 10,),
                                                        //     Text(
                                                        //       "Charge Type: ${hotelRoomDetails[index].cancellationPolicies![Index].chargeType}",
                                                        //       maxLines: 2,
                                                        //       style: TextStyle(
                                                        //           fontSize: 14,
                                                        //           fontWeight: FontWeight.w600,
                                                        //           color: Colors.green
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        // SizedBox(height: 5,),
                                                        // Row(
                                                        //   children: [
                                                        //     Icon(Icons.circle,size: 18,),
                                                        //     SizedBox(width: 10,),
                                                        //     Text(
                                                        //       "Currency: ${hotelRoomDetails[index].cancellationPolicies![Index].currency}",
                                                        //       maxLines: 2,
                                                        //       style: TextStyle(
                                                        //           fontSize: 14,
                                                        //           fontWeight: FontWeight.w600,
                                                        //           color: Colors.green
                                                        //       ),
                                                        //     ),
                                                        //   ],
                                                        // ),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.circle,size: 18,),
                                                            SizedBox(width: 10,),
                                                            Text(
                                                              "From: ${hotelRoomDetails[index].cancellationPolicies![Index].fromDate}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.green
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Icon(Icons.circle,size: 18,),
                                                            SizedBox(width: 10,),
                                                            Text(
                                                              "To: ${hotelRoomDetails[index].cancellationPolicies![Index].toDate}",
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: Colors.green
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                      ],
                                                    ),
                                                  );
                                                  }
                                                  )
                                               ],
                                             )

                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.check,size: 20,color: Colors.green,),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: Text(
                                          "${hotelRoomDetails[index].cancellationPolicy!.replaceAll(
                                              "#^#",
                                              '.\n').replaceAll("|#!#", '')}",
                                          maxLines: 6,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(Icons.smoking_rooms,size: 20,),
                                    SizedBox(width: 10,),
                                    Text(
                                      "${hotelRoomDetails[index].smokingPreference}",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                // FittedBox(
                                //   fit: BoxFit.scaleDown,
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.free_breakfast_outlined,size: 20,),
                                //       SizedBox(width: 10,),
                                //       Text(
                                //         "Breakfast available, pay at the property (Rs. 200)",
                                //         style: TextStyle(
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.bold
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(height: 10,),
                                // Wrap(
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Icon(Icons.ac_unit,size: 15,),
                                //         SizedBox(width: 10,),
                                //         Text(
                                //           "Air conditioniing",
                                //           style: TextStyle(
                                //               fontSize: 12
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(Icons.bathtub_outlined,size: 15,),
                                //         SizedBox(width: 10,),
                                //         Text(
                                //           "Private bathroom",
                                //           style: TextStyle(
                                //               fontSize: 12
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(Icons.tv,size: 15,),
                                //         SizedBox(width: 10,),
                                //         Text(
                                //           "Flat-screen TV",
                                //           style: TextStyle(
                                //               fontSize: 12
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         Icon(Icons.volume_off_outlined,size: 15,),
                                //         SizedBox(width: 10,),
                                //         Text(
                                //           "Soundproofing",
                                //           style: TextStyle(
                                //               fontSize: 12
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(height: 10,),
                                // FittedBox(
                                //   fit: BoxFit.scaleDown,
                                //   child: Row(
                                //     children: [
                                //       Icon(Icons.tips_and_updates_outlined,size: 20,),
                                //       SizedBox(width: 10,),
                                //       Text(
                                //         "Tip: This room is bigger than ,most in Alleppy",
                                //         style: TextStyle(
                                //             fontSize: 14
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(height: 10,),
                                // FittedBox(
                                //   fit: BoxFit.scaleDown,
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         "Only 5 rooms left on Dtrips.com",
                                //         style: TextStyle(
                                //             fontSize: 14
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(height: 10,),
                                Container(
                                  color: Colors.black45,
                                  height: 1,
                                  width: double.infinity,
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Text(
                                      "Price for 1 night",
                                      style: TextStyle(
                                          fontSize: 14
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      "Rs. ${hotelRoomDetails[index].price!.roomPrice}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    InkWell(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                margin: EdgeInsets.all(10.0),
                                                child: Wrap(
                                                  children: <Widget>[
                                                    Center(
                                                        child: Container(
                                                            height: 4.0, width: 50.0, color: Color(0xFF32335C))),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Column(
                                                      children: [
                                                        ListView.builder(
                                                            itemCount: hotelRoomDetails[index].cancellationPolicies!.length,
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemBuilder: (BuildContext ctxt, int Index) {
                                                              return Container(
                                                                padding: EdgeInsets.only(bottom: 10),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons.circle,size: 18,),
                                                                        SizedBox(width: 10,),
                                                                        Text(
                                                                          "Room price: Rs. ${hotelRoomDetails[index].price!.roomPrice}",
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 5,),
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons.circle,size: 18,),
                                                                        SizedBox(width: 10,),
                                                                        Text(
                                                                          "Taxable amount: Rs. ${hotelRoomDetails[index].price!.gst!.taxableAmount}",
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 5,),
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons.circle,size: 18,),
                                                                        SizedBox(width: 10,),
                                                                        Text(
                                                                          "Total GST amount: Rs. ${hotelRoomDetails[index].price!.totalGstAmount}",
                                                                          maxLines: 2,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 5,),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                        )
                                                      ],
                                                    )

                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Icon(Icons.info_outlined,size: 20,)
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Text(
                                      "+ Rs. ${hotelRoomDetails[index].price!.gst!.taxableAmount} taxes and charges",
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                  ],
                                ),
                                // SizedBox(height: 10,),
                                // Row(
                                //   children: [
                                //     Container(
                                //       color: Colors.green,
                                //       child: Text(
                                //         "Earn Rs. 314 Crtedits",
                                //         style: TextStyle(
                                //             fontSize: 14
                                //         ),
                                //       ),
                                //     )
                                //   ],
                                // ),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.only(left: 5,right: 5),
                                  width: double.infinity,
                                  height: 50,
                                  child: hotelRoomDetails[index].availabilityType == "Confirm" ? OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: active.contains(index) ? Colors.purple[300] : Colors.white,
                                        side: BorderSide(width: 1.0, color: Colors.purple),
                                      ),

                                      onPressed: (){
                                        late int smoking;
                                        if(hotelRoomDetails[index].smokingPreference == 'NoPreference'){
                                          setState(() {
                                            smoking = 0;
                                          });
                                        }else if(hotelRoomDetails[index].smokingPreference == 'Smoking') {
                                          setState(() {
                                            smoking = 1;
                                          });
                                        }else if(hotelRoomDetails[index].smokingPreference == 'NonSmoking') {
                                          setState(() {
                                            smoking = 2;
                                          });
                                        }else if(hotelRoomDetails[index].smokingPreference == 'Either') {
                                          setState(() {
                                            smoking = 3;
                                          });
                                        }

                                        List detail = [
                                          {
                                            "RoomIndex": hotelRoomDetails[index].roomIndex,
                                            "RoomTypeCode": "${hotelRoomDetails[index].roomTypeCode}",
                                            "RoomTypeName": "${hotelRoomDetails[index].roomTypeName}",
                                            "RatePlanCode": "${hotelRoomDetails[index].ratePlanCode}",
                                            "BedTypeCode": null,
                                            "SmokingPreference": smoking,
                                            "Supplements": null,
                                            "Price": {
                                              "CurrencyCode": "${hotelRoomDetails[index].price!.currencyCode}",
                                              "RoomPrice": hotelRoomDetails[index].price!.roomPrice,
                                              "Tax": hotelRoomDetails[index].price!.tax,
                                              "ExtraGuestCharge": hotelRoomDetails[index].price!.extraGuestCharge,
                                              "ChildCharge": hotelRoomDetails[index].price!.childCharge,
                                              "OtherCharges": hotelRoomDetails[index].price!.otherCharges,
                                              "Discount": hotelRoomDetails[index].price!.discount,
                                              "PublishedPrice": hotelRoomDetails[index].price!.publishedPrice,
                                              "PublishedPriceRoundedOff": hotelRoomDetails[index].price!.publishedPriceRoundedOff,
                                              "OfferedPrice": hotelRoomDetails[index].price!.offeredPrice,
                                              "OfferedPriceRoundedOff": hotelRoomDetails[index].price!.offeredPriceRoundedOff,
                                              "AgentCommission": hotelRoomDetails[index].price!.agentCommission,
                                              "AgentMarkUp": hotelRoomDetails[index].price!.agentMarkUp,
                                              "ServiceTax": hotelRoomDetails[index].price!.serviceTax,
                                              "TCS": hotelRoomDetails[index].price!.tcs,
                                              "TDS": hotelRoomDetails[index].price!.tds
                                            }
                                          }
                                        ];
                                       setState(() {
                                         print(hotelRoomDetails.length);

                                         active.contains(index) ? details.remove(selectedRooms[0]['HotelRoomsDetails'][0]):details.add(detail[0]);
                                         active.contains(index) ? print('removed') : print('added');
                                         print(detail.length);

                                         selectedRooms = [
                                           {
                                            "ResultIndex": widget.resultIndex,
                                            "HotelCode": "${widget.hotelCode}",
                                            "HotelName": "${widget.hotelName}",
                                            "GuestNationality": "IN",
                                            "NoOfRooms": "",
                                            "ClientReferenceNo": 0,
                                            "IsVoucherBooking": "true",
                                            "CategoryId": "${hotelRoomDetails[index].categoryId}",
                                            "EndUserIp": "$ip",
                                            "TokenId": "${widget.tokenId}",
                                            "TraceId": "${widget.traceId}",
                                            "HotelRoomsDetails": details
                                         }
                                         ];


                                         _handleTap(index);
                                       });

                                       print(active);
                                       print(active.contains(index));
                                         print(selectedRooms[0]['HotelRoomsDetails']);
                                         print("*************");
                                        print(selectedRooms);

                                      },
                                      child: Text(
                                        active.contains(index) ?  "Selected" : "SELECT",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: active.contains(index) ? Colors.white : Colors.purple
                                        ),
                                      )) :
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(width: 1.0, color: Colors.grey),
                                      ),
                                      onPressed: null,
                                      child: Text(
                                        "NOT-Available",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey
                                        ),
                                      )),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 30,);
                    },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void GetRooms() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/hotel-room'),
      body: jsonEncode({
        "HotelCode": widget.hotelCode,
        "ResultIndex": widget.resultIndex,
        "TraceId": widget.traceId,
        "TokenId": widget.tokenId,
        "EndUserIp": "$ips",
        // "CategoryId": widget.categoryIndex
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    final result = hotelRoomsFromJson(response.body);

    print("result : ${result.getHotelRoomResult}");

    if(response.statusCode == 200){
      setState(() {
        hotelRoomDetails = result.getHotelRoomResult.hotelRoomsDetails!;
        roomCombinationsArray = result.getHotelRoomResult.roomCombinationsArray!;
        ip = ips!;
      });

    }





  }

  void reserveRooms() async {
    setState(() {
      hotelRoomDetail = details;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/block-room'),
      body: jsonEncode(
        {
          "ResultIndex": widget.resultIndex,
          "HotelCode": "${widget.hotelCode}",
          "HotelName": "${widget.hotelName}",
          "GuestNationality": "IN",
          "NoOfRooms": "",
          "ClientReferenceNo": 0,
          "IsVoucherBooking": "true",
          "CategoryId": "${hotelRoomDetails[0].categoryId}",
          "EndUserIp": "$ips",
          "TokenId": "${widget.tokenId}",
          "TraceId": "${widget.traceId}",
          "HotelRoomsDetails": details
        }
      ),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    if(response.statusCode == 200){

      Get.to(RoomBookPage(
        noOfRooms: StoredGuest.length,
        hotelName: widget.hotelName,
        hotelCode: widget.hotelCode,
        resultIndex: widget.resultIndex,
        tokenId: widget.tokenId,
        traceId: widget.traceId,
        hotelRoomDetails: details.toList(),
        night: widget.night,
        checkin: widget.checkin,
        checkout: widget.checkout,
        categoryId: widget.categoryId,
      )
      );

    } else {
      print(response.statusCode);


    }



  }

}
