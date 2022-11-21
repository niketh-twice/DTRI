// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../widgets/widgets.dart';
// import '../search/HotelSearchFilter.dart';
//
// class SearchPage extends StatefulWidget {
//   const SearchPage({Key? key}) : super(key: key);
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
// TextEditingController _controller = TextEditingController();
//
// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromRGBO(255, 255, 255, 1.0),
//             Color.fromRGBO(255, 255, 255, 1.0),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Positioned(
//           //   top: -250,
//           //   left: -40,
//           //   child: topWidget(screenSize.width),
//           // ),
//           GestureDetector(
//             onTap: () {
//               if (!FocusScope.of(context).hasPrimaryFocus) {
//                 FocusScope.of(context).unfocus();
//               }
//             },
//             child: Scaffold(
//               backgroundColor: Colors.transparent,
//              appBar: AppBar(
//                backgroundColor: Colors.transparent,
//                shadowColor: Colors.transparent,
//                leading: Padding(
//                  padding: const EdgeInsets.only(bottom: 30,left: 10),
//                  child: InkWell(
//                    //onTap: () => Get.back(),
//                    child: CircleAvatar(
//                      backgroundColor: Colors.transparent,
//                      child: Image.asset('assets/images/icons/left-arrow.png'),
//                      radius: 15,
//                    ),
//                    //Icon(Icons.arrow_back,size: 30,color: Colors.black,),
//                  ),
//                ),
//                toolbarHeight: 80,
//                leadingWidth: 45,
//                title: Column(
//                  children: [
//                    TextField(
//                      controller: _controller,
//                      textInputAction: TextInputAction.search,
//                      // maxLength: 60,
//                      textCapitalization: TextCapitalization.words,
//                      onChanged: (text) {
//                        setState(() {
//
//                        });
//                      },
//                      decoration: InputDecoration(
//
//                        prefixIcon: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: () {  },),
//                        suffixIcon: hidingIcon(),
//
//                        hintText: 'Search',
//                        hintStyle: TextStyle(
//                          fontFamily: 'Metropolis',
//                          fontSize:
//                          MediaQuery.of(context).textScaleFactor * 16,
//                          color: Color(0xff000000),
//                        ),),
//                    ),
//                    SizedBox(height: 5,),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.end,
//                      children: [
//                        InkWell(
//                          onTap: (){
//                            showModalBottomSheet<void>(
//                              context: context,
//                              builder: (BuildContext context) {
//                                return Container(
//                                  margin: EdgeInsets.all(10.0),
//                                  child: Wrap(
//                                    children: <Widget>[
//                                      Center(
//                                          child: Container(
//                                              height: 4.0, width: 50.0, color: Color(0xFF32335C))),
//                                      SizedBox(
//                                        height: 10.0,
//                                      ),
//                                      Column(
//                                        children: [
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'popularity',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Price (lowest - highest)',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Price (highest - lowest)',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Star rating (0-5)',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Star rating (5-0)',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Row(
//                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                            children: [
//                                              Text(
//                                                'Name (A-Z)',
//                                                style: TextStyle(fontSize: 16.0),
//                                              ),
//                                              Radio(
//                                                value: 0,
//                                                groupValue: null,
//                                                onChanged: (value) {
//                                                  setState(() {
//
//                                                  });
//                                                  print("radiofirst");
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                        ],
//                                      )
//
//                                    ],
//                                  ),
//                                );
//                              },
//                            );
//                          },
//                          child: Container(
//                            child: Row(
//                              children: [
//                                Icon(Icons.swap_vert_outlined,color: Colors.black,),
//                                Text("Sort",style: TextStyle(
//                                  fontSize: 14,color: Colors.black
//                                ),)
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(width: 10,),
//                        InkWell(
//                          onTap: (){
//                            Get.to(HotelFilter());
//                          },
//                          child: Container(
//                            child: Row(
//                              children: [
//                                Icon(Icons.filter_list,color: Colors.black,),
//                                Text("Filters",style: TextStyle(
//                                    fontSize: 14,color: Colors.black
//                                ),)
//                              ],
//                            ),
//                          ),
//                        )
//                      ],
//                    )
//                  ],
//                ),
//              ),
//               body: SafeArea(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   Widget? hidingIcon() {
//     if ( _controller.text.length > 0) {
//       return IconButton(
//           icon: Icon(
//             Icons.clear,
//             color: Colors.grey,
//           ),
//           // splashColor: Colors.redAccent,
//           onPressed: () {
//             setState(() {
//               _controller.clear();
//
//             });
//           });
//     } else {
//       return null;
//     }
//   }
//
//
//
// }
