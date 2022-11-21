import 'dart:async';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant.dart';
import '../../items.dart';
import '../../widgets/boxdestination.dart';
import '../../widgets/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController(text: username);

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
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     InkWell(
                          //       onTap: () => Get.back(),
                          //       child: CircleAvatar(
                          //         backgroundColor: Colors.white,
                          //         child: Image.asset('assets/images/icons/left-arrow.png'),
                          //         radius: 15,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print('Change image');
                                    },
                                    child: userimg.isEmpty
                                        ? CircleAvatar(
                                            radius: 75,
                                            backgroundColor: Colors.black12,
                                            child: CircleAvatar(
                                              radius: 70,
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                  'assets/images/avatar.png'),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 75,
                                            backgroundColor: Colors.black12,
                                            child: CircleAvatar(
                                              radius: 70,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                '$userimg',
                                              ),
                                            ),
                                          ),
                                  ),
                                  Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: InkWell(
                                      onTap: () {
                                        print('Change image');
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.add_a_photo,
                                              color: Colors.black),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.black12,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                50,
                                              ),
                                            ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(2, 4),
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 3,
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),

                          Row(
                            children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                          Theme(
                            data: Theme.of(context)
                                .copyWith(backgroundColor: Color(0xff92278f)),
                            child: TextField(
                              controller: nameController,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff92278f)),
                                ),
                                hintText: 'Enter Your Name',
                                hintStyle: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: [
                              Text(
                                "Mobile Number",
                                style: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),

                            ],
                          ),

                          Theme(
                            data: Theme.of(context)
                                .copyWith(backgroundColor: Color(0xff92278f)),
                            child: IntlPhoneField(
                              // controller: phoneController,
                              textAlign: TextAlign.justify,
                              autovalidateMode: AutovalidateMode.disabled,
                              disableLengthCheck: true,
                              showCountryFlag: true,
                              showDropdownIcon: false,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xff92278f)),
                                ),
                                hintText: 'Enter Your Mobile Number',
                                hintStyle: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              initialCountryCode: 'IN',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            ),


                            // TextField(
                            //   maxLines: 1,
                            //   style: TextStyle(
                            //       fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                            //       fontFamily: 'Metropolis',
                            //       color: Colors.black,
                            //       fontWeight: FontWeight.bold),
                            //   decoration: InputDecoration(
                            //     focusedBorder: UnderlineInputBorder(
                            //       borderSide:
                            //           BorderSide(color: Color(0xff92278f)),
                            //     ),
                            //     hintText: 'Enter Your Mobile Number',
                            //     hintStyle: TextStyle(
                            //         fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                            //         fontFamily: 'Metropolis',
                            //         color: Colors.black54,
                            //         fontWeight: FontWeight.bold),
                            //   ),
                            // ),
                          ),

                          SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: [
                              Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Theme(
                            data: Theme.of(context)
                                .copyWith(backgroundColor: Color(0xff92278f)),
                            child: TextField(
                              maxLines: 6,
                              style: TextStyle(
                                  fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                  fontFamily: 'Metropolis',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff92278f)),
                                ),
                                hintText: 'Enter Your Address',
                                hintStyle: TextStyle(
                                    fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                    fontFamily: 'Metropolis',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
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
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40.0, vertical: 20.0),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: StadiumBorder(),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                                      fontFamily: 'Metropolis',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 50,
                          ),

                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffffffff), Color(0xffffffff)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x1D000000),
                                    blurRadius: 5.0,
                                    spreadRadius: 3,
                                    offset: Offset(
                                      2,
                                      3,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () {
                                print('Change Password');
                                Get.to(EditProfilePage());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/icons/key.png'),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Change Password",
                                        style: TextStyle(
                                            fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),

                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Color(0xffffffff), Color(0xffffffff)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x1D000000),
                                    blurRadius: 5.0,
                                    spreadRadius: 3,
                                    offset: Offset(
                                      2,
                                      3,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(16)),
                            child: InkWell(
                              onTap: () {
                                print('Delete Account');
                                Get.to(EditProfilePage());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                            'assets/images/icons/delete.png'),
                                        radius: 15,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Delete Account",
                                        style: TextStyle(
                                            fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                            fontFamily: 'Metropolis',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
