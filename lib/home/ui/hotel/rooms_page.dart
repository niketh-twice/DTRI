import 'package:dtrip_login/home/ui/dashboard.dart';
import 'package:dtrip_login/home/ui/hotel/models/roomModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../global.dart';



class RoomSelectionPage extends StatefulWidget {
  const RoomSelectionPage({Key? key, }) : super(key: key);

  @override
  State<RoomSelectionPage> createState() => _RoomSelectionPageState();
}

class _RoomSelectionPageState extends State<RoomSelectionPage> {

  List Guest = [RoomModel(1, 1, 0, []).toJson()];
  var childage = 0;
  late RoomModel roomModel = RoomModel( 1, 1, 0,List<int>.empty(growable: true),);

  @override
  void initState() {
    print('Guest : $Guest');
    print('StoredGuest : $StoredGuest');
    print('count : $GuestCount');
    print('.........');

    Guest = StoredGuest;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;
    return Container(
      decoration: const BoxDecoration(
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
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Get.to(Dashboard());
                },
                icon: Icon(Icons.arrow_back,color: Colors.black,),
              ),

              centerTitle: false,
              title: Text(
                "Rooms and Guests",
                style: TextStyle(
                    fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: screenSize.width / 2,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: const LinearGradient(
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
                    onUpdate();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20.0),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                      fontFamily: 'Metropolis',
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Number of rooms
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // height: 50,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 1),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(16))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rooms",
                                style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                  children : [
                                    OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          print(Guest.last);
                                          int adult = Guest.last['NoOfAdults'];
                                          int child = Guest.last['NoOfChild'];

                                          Guest.length == 1 ? null :GuestCount = GuestCount-(adult+child);

                                          Guest.length == 1 ? null : Guest.removeLast();
                                          roomModel.roomNo == 1 ? null :roomModel.roomNo--;
                                          // roomModel.adultNo = roomModel.adultNo - adult;
                                          // roomModel.childNo = roomModel.childNo - child;


                                        });
                                      },
                                      child: Icon(Icons.remove,size: 25,),
                                      style: OutlinedButton.styleFrom(
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                    Text(
                                      "${Guest.length}",
                                      style: TextStyle(
                                        //    fontWeight: FontWeight.bold,
                                        fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          Guest.add(RoomModel(roomModel.roomNo, 1, 0, []).toJson());
                                          roomModel.roomNo ++;
                                          roomModel.adultNo = roomModel.adultNo +1;
                                          GuestCount++;
                                        });
                                      },
                                      child: Icon(Icons.add,size: 25,),
                                      style: OutlinedButton.styleFrom(
                                        shape: CircleBorder(),
                                      ),
                                    ),
                                  ]
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      ListView.builder(
                          shrinkWrap: true,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: Guest.length,
                          itemBuilder: (context, key) {
                            return _room(key);
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _room( int key) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation.name;

    return Column(
      children: [
        SizedBox(height: 20,),
        Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 1),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(16))),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Room ${key+1}",
                      style: TextStyle(
                          fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                          fontFamily: 'Metropolis',
                          color: Colors.black,
                          fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              //Number of Guests

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Adults",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Above 12 years",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                              fontFamily: 'Metropolis',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                        children : [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Guest[key]['NoOfAdults'] == 1 ? null : GuestCount--;
                                Guest[key]['NoOfAdults'] == 1 ? null : Guest[key]['NoOfAdults']--;
                                Guest[key]['NoOfAdults'] == 1 ? null : roomModel.adultNo--;

                              });
                            },
                            child: Icon(Icons.remove,size: 25,),
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                            ),
                          ),
                          Text(
                            "${Guest[key]['NoOfAdults']}",
                            style: TextStyle(
                              // fontWeight: FontWeight.bold,
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Guest[key]['NoOfAdults']++;
                                GuestCount++;
                                roomModel.adultNo++;
                              });
                            },
                            child: Icon(Icons.add,size: 25,),
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Childrens",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "0 - 12 years",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                              fontFamily: 'Metropolis',
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                        children : [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                Guest[key]['NoOfChild'] == 0 ? null :GuestCount--;
                                Guest[key]['NoOfChild'] == 0 ? null : Guest[key]['NoOfChild']--;
                                Guest[key]['ChildAge'].length == 0 ? null : Guest[key]['ChildAge'].removeLast();
                                Guest[key]['NoOfChild'] == 0 ? null : roomModel.childNo--;
                              });
                            },
                            child: Icon(Icons.remove,size: 25,),
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                            ),
                          ),
                          Text(
                            "${Guest[key]['NoOfChild']}",
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              showMaterialNumberPicker(
                                  context: context,
                                  title: "Pick Child's Age",
                                  maxNumber: 17,
                                  minNumber: 0,
                                  selectedNumber: childage,
                                  onChanged: (value) => setState(() => childage = value),
                                  onConfirmed: (){
                                    setState(() {
                                      Guest[key]['ChildAge'].add(childage);
                                      Guest[key]['NoOfChild']++;
                                      roomModel.childNo++;
                                      GuestCount++;
                                    });
                                  }
                              );
                            },
                            child: Icon(Icons.add,size: 25,),
                            style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),

              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: Guest[key]['NoOfChild'],
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              // 'Child ${index+1}',
                              'Child ${Guest[key]['NoOfChild']}',
                              textAlign: TextAlign.center,
                            ),

                            TextButton(
                              onPressed: () {
                                showMaterialNumberPicker(
                                    context: context,
                                    title: "Pick Child's Age",
                                    maxNumber: 17,
                                    minNumber: 0,
                                    selectedNumber: Guest[key]['ChildAge'][index],
                                    onChanged: (value){
                                      setState(() {
                                        childage = value;
                                      });
                                    },
                                    onConfirmed: (){
                                      setState(() {
                                        Guest[key]['ChildAge'][index] = childage;
                                      });
                                    }
                                );
                              },
                              child: Text(
                                  '${Guest[key]['ChildAge'][index]} years old'
                              ),)
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onUpdate() {
    Get.to(Dashboard());
    setState(() {
      print(roomModel.toJson());
      print(roomModel.adultNo);
      var count = roomModel.adultNo+roomModel.childNo;
      print(count);
      room = "${GuestCount} Guest,${Guest.length} Room";
      print(Guest[0]);
      print(Guest);

      StoredGuest=Guest;

    });
  }
}
