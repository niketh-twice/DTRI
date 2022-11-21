import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class FlightListPage extends StatefulWidget {
  const FlightListPage({Key? key}) : super(key: key);

  @override
  State<FlightListPage> createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
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
                    onTap: () => Get.back(),
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
                          // controller: searchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Image.asset('assets/images/icons/search.png'),
                              // const Icon(
                              //   FontAwesomeIcons.magnifyingGlass,
                              //   color: Color(0xff000000),
                              // ),
                              onPressed: () async {
                                // searchController.clear();
                                // await getbookcatogerywise(isRefresh: true);
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
                          onChanged: (value) async {
                            //await getbookcatogerywise(isRefresh: true);
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    'assets/images/icons/current-location.png')),
                            title: Text(
                              "Choose your current location",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        color: Color(0x91d8d0dc),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Popular cities",
                                style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
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
                        child: InkWell(
                          onTap: () {},
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    'assets/images/icons/location.png')),
                            title: Text(
                              "Mumbai",
                              style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/24 : screenSize.height/24,
                                fontFamily: 'Metropolis',
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              "India",
                              style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/28 : screenSize.height/28,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height,
                      )
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
}
