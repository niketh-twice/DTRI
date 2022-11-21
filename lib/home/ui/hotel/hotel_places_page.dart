import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import '../../../db/Hotel/PlaceSearch.dart';
import '../../../db/api.dart';
import '../../global.dart';
import '../../widgets/widgets.dart';
import '../dashboard.dart';

class HotelPlacesPage extends StatefulWidget {
  const HotelPlacesPage({Key? key}) : super(key: key);

  @override
  State<HotelPlacesPage> createState() => _HotelPlacesPageState();
}

class _HotelPlacesPageState extends State<HotelPlacesPage> {

  bool loading = true;

  List<HotelPlaceSearch> _placelist = [];
  int onset = 0;
  int offset = 10;
  late int totalPages;
  TextEditingController searchController = new TextEditingController();

  final RefreshController refreshController1 = RefreshController(
      initialRefresh: false);

  Future getplace({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        offset = offset+10;
      });
    } else {
      if (offset >= 500) {
        refreshController1.loadNoData();
        return false;
      }
    }

    final response = await http.post(
      Uri.parse('${api}api/city/page'),
      body: jsonEncode({
          "off": onset,
          "on": offset,
          "keyword": searchController.text.toString(),
          //"page": currentPage.toString()
      }),
      headers: {"content-type": "application/json"},
    );

    setState(() {
      onset = offset+1;
      offset= offset+10;
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      loading = false;
      final result = hotelPlaceSearchFromJson(response.body);

      if (isRefresh) {
        _placelist = result;
      } else {
         _placelist.addAll(result);
      }

      print(response.body);
      setState(() {
        // totalPages = result.totalPages;
      });
      return true;
    } else {
      return false;
    }
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
          GestureDetector(
            onTap: () {
              if (!FocusScope.of(context).hasPrimaryFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                leadingWidth: 40,
                leading: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        offset = 10;
                        onset = 0;
                      });
                      Get.back();
                      },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/images/icons/left-arrow.png'),
                      radius: 15,
                    ),
                  ),
                ),
                title: PreferredSize(
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffece8ed), Color(0xffece8ed)],
                        ),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                           controller: searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Image.asset('assets/images/icons/search.png'),
                              // const Icon(
                              //   FontAwesomeIcons.magnifyingGlass,
                              //   color: Color(0xff000000),
                              // ),
                              onPressed: () async {
                                // searchController.clear();
                                 await getplace(isRefresh: true);
                              },
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                              color: Color(0xff000000),
                            ),
                            border:
                            OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (value)async {
                            setState(() {
                              onset = 0;
                              offset = 10;
                            });
                            await getplace(isRefresh: true);
                            if(searchController.text.isEmpty){
                              setState(() {
                                onset = 0;
                                offset = 10;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  preferredSize: Size(10, 20),
                ),
                toolbarHeight: 65,
              ),
              body: SafeArea(
                child: loading
                    ? Container(
                  child: Center(child: Text("Search your destination...")),
                )
                    : _placelist.isEmpty
                    ? Container(
                  child: Center(
                    child: Text("Empty"),
                  ),
                )
                    :
                SmartRefresher(
                  controller: refreshController1,
                  enablePullUp: true,
                  onRefresh: () async {
                    final result = await getplace(isRefresh: true);
                    if (result) {
                      refreshController1.refreshCompleted();
                    } else {
                      refreshController1.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    print("loading");
                    final result = await getplace(isRefresh:false);
                    if (result) {
                      refreshController1.loadComplete();
                    } else {
                      refreshController1.loadFailed();
                    }
                  },

                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final items = _placelist[index];

                      return InkWell(
                        onTap: () {
                          setState(() {
                             countryCode = _placelist[index].countrycode!;
                             cityId = _placelist[index].cityid!;
                             country = _placelist[index].country!;
                             city = _placelist[index].destination!;
                             offset = 10;
                             onset = 0;
                          });

                          Get.to(Dashboard());
                        },
                        child: ListTile(
                          title: Text(
                            "${_placelist[index].destination}",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/23 : screenSize.height/23,
                                fontFamily: 'Metropolis',
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${_placelist[index].country}",
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),

                        ),
                      );
                    },
                    // separatorBuilder: (context, index) => SizedBox(),
                    itemCount:_placelist.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
