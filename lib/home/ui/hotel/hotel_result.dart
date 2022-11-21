import 'dart:convert';

import 'package:dtrip_login/home/ui/hotel/single_hotel_page.dart.dart';
import 'package:dtrip_login/home/ui/hotel/hotel_book_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../db/Hotel/SingleHotelModel.dart';
import '../../../db/Hotel/hotel_model.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../../widgets/widgets.dart';
import '../search/HotelSearchFilter.dart';

class HotelResultPage extends StatefulWidget {
  HotelResultPage({Key? key, this.night, this.checkinDate, this.checkoutDate, this.inDate, this.outdate, this.countryCode, this.cityId}) : super(key: key);
  final night;
  final checkinDate;
  final checkoutDate;
  final inDate;
  final outdate;
  final countryCode;
  final cityId;
  @override
  State<HotelResultPage> createState() => _HotelResultPageState();
}
enum SORT {pop, pL2H, pH2L,rL2H,rH2L,name }
class _HotelResultPageState extends State<HotelResultPage> {
  String? newValue;
  SORT? _new = SORT.pop;
  var  body = "empty";
  bool loading = true;
  int currentPage = 1;
  late int totalPages;

  var sts = 0;
  var categoryId='';

  var traceId = "";
  var tokenId="";


  List<HotelResult> searchResult = [];






  List<HotelInfoResult> singleResult = [];

  TextEditingController _controller = TextEditingController();

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

 

  


  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    print('refresher loading...');
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    print('refreshed');
    setState(() {
      print(sts);
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }


  @override
  void initState() {
    print(StoredGuest.length);
    print(StoredGuest);
    print(widget.checkinDate);
    print(widget.night);
    getHotel();
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
      child: loading ? Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!FocusScope.of(context).hasPrimaryFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar:  searchResult.isEmpty? null :AppBar(
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
                    //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
                  ),
                ),
                toolbarHeight: 80,
                leadingWidth: 45,
                title: Column(
                  children: [
                    TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.search,
                      // maxLength: 60,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (text) {
                        setState(() {

                        });
                      },
                      decoration: InputDecoration(

                        prefixIcon: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: () {  },),
                        suffixIcon: hidingIcon(),

                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize:
                          MediaQuery.of(context).textScaleFactor * 16,
                          color: Color(0xff000000),
                        ),),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'popularity',
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                              Radio<SORT>(
                                                value: SORT.pop,
                                                groupValue: _new,
                                                onChanged: ( value) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _new = value;
                                                    _new == SORT.pop ? searchResult.sort((a, b) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;
                                                  });
                                                },
                                              )





                                              // Radio(
                                              //   value: 'popularity',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'popularity' ? searchResult.sort((a, b) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Price (lowest - highest)',
                                                style: TextStyle(fontSize: 16.0),
                                              ),

                                              Radio<SORT>(
                                                value: SORT.pL2H,
                                                groupValue: _new,
                                                onChanged: (SORT? value) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _new = value;
                                                    _new == SORT.pL2H ? searchResult.sort((a, b) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;
                                                  });
                                                },
                                              )



                                              // Radio(
                                              //   value:'Price (lowest - highest)',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'Price (lowest - highest)' ? searchResult.sort((a, b) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Price (highest - lowest)',
                                                style: TextStyle(fontSize: 16.0),
                                              ),

                                              Radio<SORT>(
                                                value: SORT.pH2L,
                                                groupValue: _new,
                                                onChanged: (SORT? value) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _new = value;
                                                    _new == SORT.pH2L ? searchResult.sort((b, a) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;

                                                  });
                                                },
                                              )




                                              // Radio(
                                              //   value: 'Price (highest - lowest)',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'Price (highest - lowest)' ? searchResult.sort((b, a) => a.price!.roomPrice!.compareTo(b.price!.roomPrice!.toInt())):null;
                                              //
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Star rating (0-5)',
                                                style: TextStyle(fontSize: 16.0),
                                              ),

                                              Radio<SORT>(
                                                value: SORT.rL2H,
                                                groupValue: _new,
                                                onChanged: (SORT? value) {
                                                  Navigator.pop(context);
                                                  setState(() {

                                                    // var list = searchResult.where((searchResult) => searchResult.starRating! <3);
                                                    //     print(list);
                                                   _new = value;
                                                   _new == SORT.rL2H ? searchResult.sort((a, b) => a.starRating!.compareTo(b.starRating!)):null;

                                                  });
                                                },
                                              )



                                              // Radio(
                                              //   value: 'Star rating (0-5)',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'Star rating (0-5)' ? searchResult.sort((a, b) => a.starRating!.compareTo(b.starRating!)):null;
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Star rating (5-0)',
                                                style: TextStyle(fontSize: 16.0),
                                              ),

                                              Radio<SORT>(
                                                value: SORT.rH2L,
                                                groupValue: _new,
                                                onChanged: (SORT? value) {
                                                  Navigator.pop(context);
                                                   setState(() {
                                                     _new = value;
                                                    _new == SORT.rH2L ? searchResult.sort((b, a) => a.starRating!.compareTo(b.starRating!)):null;
                                                     print(value);

                                                    //  var list = searchResult.where((searchResult) => searchResult.starRating! < 4);
                                                    //  print(list);



                                                     // var last  =  searchResult.where((searchResult)
                                                     //            => searchResult.hotelName!.toLowerCase().contains("ra".toLowerCase()));null;
                                                     // print(last);

                                                        // a.hotelName!.toLowerCase().compareTo(b.hotelName!.toLowerCase())
                                                      //you can add another filter conditions too




                                                  });

                                                },
                                              )



                                              // Radio(
                                              //   value: 'Star rating (5-0)',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'Star rating (5-0)' ? searchResult.sort((b, a) => a.starRating!.compareTo(b.starRating!)):null;
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Name (A-Z)',
                                                style: TextStyle(fontSize: 16.0),
                                              ),

                                              Radio<SORT>(
                                                value: SORT.name,
                                                groupValue: _new,
                                                onChanged: (SORT? value) {
                                                  Navigator.pop(context);
                                                  setState(() {


                                                    _new = value;
                                                    _new == SORT.name ? searchResult.sort((a, b) => a.hotelName!.toLowerCase().compareTo(b.hotelName!.toLowerCase())):null;
                                                  });
                                                },
                                              )


                                              // Radio(
                                              //   value: 'Name (A-Z)',
                                              //   groupValue: newValue,
                                              //   onChanged: (value) {
                                              //     setState(() {
                                              //       newValue = value;
                                              //       newValue == 'Name (A-Z)' ? searchResult.sort((a, b) => a.hotelName!.toLowerCase().compareTo(b.hotelName!.toLowerCase())):null;
                                              //
                                              //     });
                                              //     print("radiofirst");
                                              //   },
                                              // ),
                                            ],
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.swap_vert_outlined,color: Colors.black,),
                                Text("Sort",style: TextStyle(
                                    fontSize: 14,color: Colors.black
                                ),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            Get.to(HotelFilter());
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.filter_list,color: Colors.black,),
                                Text("Filters",style: TextStyle(
                                    fontSize: 14,color: Colors.black
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              body: SafeArea(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(),

                  child: _check(),

                ),
              ),
            ),
          ),
        ],
      ) :
      Center(child: Container(
          child: Lottie.asset(
              'assets/lottie/loading.json',
              fit: BoxFit.contain)),)
      ,
    );
  }

  getHotel() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    print("ip : $ips");

    final response = await http.post(
      Uri.parse(api + 'api/hotels/search'),
      body: jsonEncode({
        "CheckInDate": "${widget.checkinDate}",
        "NoOfNights": widget.night,
        "ResultCount": 50,
        "PreferredCurrency": "INR",
        "MaxRating": 5,
        "GuestNationality": "IN",
        "NoOfRooms": StoredGuest.length,
        "IsNearBySearchAllowed": false,
        "RoomGuests":StoredGuest,
        "CityId": widget.cityId,
        "MinRating": 1,
        // "TokenId": "632322cd-83c4-48d2-b226-6d0c6f832d9b",
        "CountryCode": widget.countryCode,
        "ReviewScore": 0,
        "EndUserIp": "$ips"

      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);



    print(response.statusCode);

    if(response.statusCode == 200) {

      // Map<String, dynamic> data =
      // new Map<String, dynamic>.from(json.decode(response.body));
      //
      // print(data);

      final result = hotelSearchFromJson(response.body);


      print(result.hotelSearchResult!.error!.errorCode);

      print("token : ${result.token}");


      searchResult.addAll(result.hotelSearchResult!.hotelResults);

       if (result.hotelSearchResult!.error!.errorCode == 0) {
        setState(() {
          sts = 200;
        });
      } else if(result.hotelSearchResult!.error!.errorCode == 2){
        setState(() {
          sts = 1;
        });
      }
      setState(() {
        body = response.body.toString();
        traceId = "${result.hotelSearchResult!.traceId}";
        tokenId=result.token;
        // categoryId="${result.hotelSearchResult.hotelResults[0]}";

      });
    }
    else {
      setState(() {
        body = response.statusCode.toString();
      });

    }
  }

  void goToSingle(int index) async {

    print(tokenId);
    setState(() {
      loading = false;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ips = prefs.getString('ip');
    final response = await http.post(
      Uri.parse(api + 'api/hotels/hotel-info'),
      body: jsonEncode({
        "HotelCode": "${searchResult[index].hotelCode}",
        "ResultIndex": searchResult[index].resultIndex,
        "TraceId": traceId,
        "TokenId": tokenId,
        "EndUserIp": "$ips",
        "CategoryId":"${searchResult[index].supplierHotelCodes!.isEmpty?'null':searchResult[index].supplierHotelCodes![0].categoryId }"
      }),
      headers: {"content-type": "application/json"},
    );
    print(response.body);
    print(response.statusCode);

    final result = singleHotelFromJson(response.body);

    print("token : ${result}");
    // singleResult.addAll(result.hotelInfoResult.hotelDetails);



    if(response.statusCode == 200){

      setState(() {
        loading = true;
      });
      if(result.hotelInfoResult!.error!.errorCode == 3){
        print('invalid city id');
        setState(() {
          loading = false;
        });
      }else if(result.hotelInfoResult!.error!.errorCode == 2){
        print('No rooms Available from UAPI');
        setState(() {
          loading = false;
        });
      }
      else if (result.hotelInfoResult!.error!.errorCode == 0){
        setState(() {
          imgList=result.hotelInfoResult!.hotelDetails!.images!;
          hotelFacilities=result.hotelInfoResult!.hotelDetails!.hotelFacilities!;

            categoryId = searchResult[index].supplierHotelCodes![0].categoryId!;

        });
        Get.to(SingleHotelPage(
          discription: result.hotelInfoResult!.hotelDetails!.description,
          picture: searchResult[index].hotelPicture,
          images: result.hotelInfoResult!.hotelDetails!.images,
          price: searchResult[index].price!.roomPrice,
          address: result.hotelInfoResult!.hotelDetails!.address,
          name: searchResult[index].hotelName,
          contact: result.hotelInfoResult!.hotelDetails!.hotelContactNo,
          rating: result.hotelInfoResult!.hotelDetails!.starRating!.toDouble(),
          hotelFacilities: result.hotelInfoResult!.hotelDetails!.hotelFacilities,
          night: widget.night,
          checkin: widget.inDate,
          checkout: widget.outdate,
          latitude: result.hotelInfoResult!.hotelDetails!.latitude,
          longitude: result.hotelInfoResult!.hotelDetails!.longitude,
          tokenId: tokenId,
          traceId: traceId,
          categoryIndex: searchResult[index].supplierHotelCodes![0].categoryIndex,
          resultIndex: searchResult[index].resultIndex,
          hotelCode: searchResult[index].hotelCode,
          categoryId: searchResult[index].supplierHotelCodes![0].categoryId,
        ));
      }




    }
    else {
      setState(() {
        loading = true;
      });
      print('Something Wrong');
      print(response.statusCode);
    }




    // Get.to(SingleHotelPage());
  }

  Widget? hidingIcon() {
    if ( _controller.text.length > 0) {
      return IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          // splashColor: Colors.redAccent,
          onPressed: () {
            setState(() {
              _controller.clear();

            });
          });
    } else {
      return null;
    }
  }



  _check() {
    if(sts == 200){
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: searchResult.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final items = searchResult[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        InkWell(
                          onTap: () {
                            print(index);

                            print(searchResult[index].hotelCode);
                            print(searchResult[index].supplierHotelCodes!.isEmpty?'null':searchResult[index].supplierHotelCodes![0].categoryId);
                            goToSingle(index);
                          },
                          child: Row(

                            children: [
                              Container(
                                height: 150,
                                width: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(16), // Image radius
                                    child: Image.network(
                                      '${items.hotelPicture}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        // Appropriate logging or analytics, e.g.
                                        // myAnalytics.recordError(
                                        //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                        //   exception,
                                        //   stackTrace,
                                        // );
                                        return Container(
                                          height: 200,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            image: new DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/no-img.png"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(

                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${items.hotelName}",
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width/18,
                                              fontWeight: FontWeight.w500
                                          ),),

                                        Text(
                                          "${items.hotelAddress}",
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/24,
                                          ),
                                        ),

                                        RatingBarIndicator(
                                          rating: items.starRating!.toDouble(),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 30.0,
                                          direction: Axis.horizontal,
                                        ),
                                        //  Text("Rating : ${items.starRating}",),

                                        Text(
                                          "₹${items.price!.roomPrice}",
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width/24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Divider(
                          height: 20,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.black54,
                        ),

                      ],
                    ),
                  );
                }),







            //
            // Center(
            //   child: SelectableText(
            //     body
            //   ),
            // ),







            SizedBox(
              height: 10,
            )
          ],
        ),
      );
    } else if (sts == 1) {
       return Center(child: Text(
        "No Result Found!",
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600
        ),
      ),);
    } else if (sts == 0){
      return Center(child: Container(
          child: Lottie.asset(
              'assets/lottie/loading.json',
              fit: BoxFit.contain)),);
    }
  }
}
