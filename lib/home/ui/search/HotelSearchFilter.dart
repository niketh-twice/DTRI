import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../db/Hotel/hotel_model.dart';

class HotelFilter extends StatefulWidget {
  const HotelFilter({Key? key}) : super(key: key);

  @override
  State<HotelFilter> createState() => _HotelFilterState();
}

class _HotelFilterState extends State<HotelFilter> {
  RangeValues _currentRangeValues = const RangeValues(0, 20000);
  var initialPrice = "0";
  var finalPrice = "20000+";
  bool rating2 = false;
  bool rating3 = false;
  bool rating4 = false;
  bool rating5 = false;
  List <HotelResult> searchResult = [];




  @override
  Widget build(BuildContext context) {



    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      floatingActionButton: Padding(
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          children: [
            const Expanded(
              flex: 40,
              child: Text(
                'Filters',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 50,
              child: ElevatedButton(
                onPressed: () {
                 // widget.onApplyFilters(filters);
                  //filters.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('APPLY'),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 50,
              child: ElevatedButton(
                onPressed: () async {
                  print('filters');
                 // filters.forEach((key, value) {
                  //   List templist = [];
                  //   if (key == "brand") {
                  //     templist = brands;
                  //   } else if (key == "price") {
                  //     templist = prices;
                  //   } else if (key == "color") {
                  //     templist = colors;
                  //   }
                  //   for (var el in value!) {
                  //     int index = templist.indexWhere((element) {
                  //       Map e = element;
                  //       return (e.keys.first.toString() ==
                  //           el.keys.first.toString());
                  //     });
                  //     setState(() {
                  //       templist[index][el.keys.first] = false;
                  //     });
                  //   }
                  // });
                  // // await resetFilter();
                  // setState(() {
                  //   filters.clear();
                  // });
                  // widget.onApplyFilters(filters);
                },
                child: const Text('RESET'),
              ),
            ),
          ],
        ),
       // child: bottomAppBarContents,
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Price per room (for 1 night)",
                style: TextStyle(
                  fontSize: 14
                ),
              ),
              SizedBox(height: 20,),
              Text(
               _currentRangeValues.start == 20000? " More than INR $initialPrice+" : "INR $initialPrice - INR $finalPrice",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              RangeSlider(
                values: _currentRangeValues,
                max: 20000,
                divisions: 40,
                labels: RangeLabels(
                  _currentRangeValues.start.round() == 20000 ? "${_currentRangeValues.start.round()}+" :_currentRangeValues.start.round() ==  _currentRangeValues.end.round() ? _currentRangeValues.end.round().toString() : _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round() == 20000 ? "${_currentRangeValues.end.round()}+" : _currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values) {

                  setState(() {
                    _currentRangeValues = values;
                    initialPrice = _currentRangeValues.start.round().toString();
                    finalPrice = _currentRangeValues.end.round() == 20000 ? "${_currentRangeValues.end.round()}+" : _currentRangeValues.end.round().toString();
                    print(values);
                  });
                },
              ),
              SizedBox(height: 20,),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black54,
              ),
              SizedBox(height: 10,),
              Text(
                "Star Rating",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 10,),
              Wrap(
                spacing: 15,
                children: [
                  ActionChip(
                      label: Text(
                          "<2 Stars",
                        style: TextStyle(
                          color: rating2? Colors.white : Colors.black
                        ),
                      ),


                    backgroundColor: rating2 ? Colors.purple : null,
                    elevation: rating2 ? 5 : 0,
                    avatar: CircleAvatar(
                      backgroundColor: rating2? Colors.white : null,
                      child: Icon(Icons.star,color: Colors.amber,),
                    ),
                    onPressed: () {
                      // List<HotelResult> filter(int starRating) {
                      //   return searchResult.where((element) => element.starRating == 2).toList() as dynamic;
                      // }
                     // Navigator.pop(context);
                        setState(() {
                         // Iterable<dynamic> rating2 = searchResult.where((starRating) => starRating.starRating! < 2).toList() as dynamic;


                          rating2 = !rating2;
                          print(rating2);


                        });
                    },
                  ),
                  ActionChip(
                    label: Text(
                      "3 Star",
                      style: TextStyle(
                        color: rating3? Colors.white : Colors.black
                    ),),
                    backgroundColor: rating3 ? Colors.purple : null,
                    elevation: rating3 ? 5 : 0,
                    avatar: CircleAvatar(
                      backgroundColor: rating3? Colors.white : null,
                      child: Icon(Icons.star,color: Colors.amber,),
                    ),
                    onPressed: () {
                      //Navigator.pop(context);
                      setState(() {
                        rating3 = !rating3;
                        print(rating3);
                      });
                    },
                  ),
                  ActionChip(
                    label: Text(
                        "4 Star",
                      style: TextStyle(
                          color: rating4? Colors.white : Colors.black
                      ),),
                    backgroundColor: rating4 ? Colors.purple : null,
                    elevation: rating4 ? 5 : 0,
                    avatar: CircleAvatar(
                      backgroundColor: rating4? Colors.white : null,
                      child: Icon(Icons.star,color: Colors.amber,),
                    ),
                    onPressed: () {
                    //  Navigator.pop(context);
                      setState(() {
                        rating4 = !rating4;
                        print(rating4);
                      });
                    },
                  ),
                  ActionChip(
                    label: Text(
                        "5 Star",
                      style: TextStyle(
                          color: rating5? Colors.white : Colors.black
                      ),
                    ),
                    backgroundColor: rating5 ? Colors.purple : null,
                    elevation: rating5 ? 5 : 0,
                    avatar: CircleAvatar(
                      backgroundColor: rating5? Colors.white : null,
                      child: Icon(Icons.star,color: Colors.amber,),
                    ),
                    onPressed: () {
                    //  Navigator.pop(context);
                      setState(() {
                        rating5 = !rating5;
                        print(rating5);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black54,
              ),
              SizedBox(height: 10,),


            ],
          ),
        ),
      ),

    );
  }
}
