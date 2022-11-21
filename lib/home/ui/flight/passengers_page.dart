import 'package:dtrip_login/home/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../widgets/widgets.dart';

String passengers = "1 Adult, 0 Child, 0 Infant";
int adult = 1;
int child = 0;
int infant = 0;
int defaultChoiceIndex = 0;
String planeClassName = "Premium Economy";

class PassengerSelectionPage extends StatefulWidget {
  const PassengerSelectionPage({Key? key}) : super(key: key);

  @override
  State<PassengerSelectionPage> createState() => _PassengerSelectionPageState();
}

class _PassengerSelectionPageState extends State<PassengerSelectionPage> {
  List<String> _choicesList = [
    'Premium Economy',
    'Economy',
    'Business',
    'First-Class'
  ];

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
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              leadingWidth: 40,
              leading: Padding(
                padding: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () => Get.to(Dashboard()),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/icons/left-arrow.png'),
                    radius: 15,
                  ),
                ),
              ),
              title: Text(
                "Passengers & Class",
                style: TextStyle(
                    fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                    fontFamily: 'Metropolis',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Number of Passengers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/icons/parents.png'),
                      ),
                      title: Text(
                        "Adults",
                        style: TextStyle(
                            fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                            fontFamily: 'Metropolis',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Above 12 years",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "On the day of travel",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/32 : screenSize.height/32,
                              fontFamily: 'Metropolis',
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 45,
                        width: 110,
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
                                Radius.circular(5))),
                        child:  Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  adult == 1 ? adult = 1 : adult--;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.minus,
                                size: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                color: Colors.black38,
                              ),
                            ),
                            Text(
                              "${adult}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  adult < 9
                                      ? adult++
                                      : adult = adult;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                size: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/icons/children.png'),
                      ),
                      title: Text(
                        "Children",
                        style: TextStyle(
                            fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                            fontFamily: 'Metropolis',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2 - 12 years",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "On the day of travel",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/32 : screenSize.height/32,
                              fontFamily: 'Metropolis',
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 45,
                        width: 110,
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
                                Radius.circular(5))),
                        child:  Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  child == 0 ? child = 0 : child--;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.minus,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                            Text(
                              "${child}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  child < 9
                                      ? child++
                                      : child = child;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/icons/baby.png'),
                      ),
                      title: Text(
                        "Infants",
                        style: TextStyle(
                            fontSize: orientation == "portrait" ? screenSize.width/22 : screenSize.height/22,
                            fontFamily: 'Metropolis',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Below 2 years",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,
                              fontFamily: 'Metropolis',
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "On the day of travel",
                            style: TextStyle(
                              fontSize: orientation == "portrait" ? screenSize.width/32 : screenSize.height/32,
                              fontFamily: 'Metropolis',
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 45,
                        width: 110,
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
                                Radius.circular(5))),
                        child:  Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  infant == 0
                                      ? infant = 0
                                      : infant--;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.minus,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                            Text(
                              "${infant}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  infant < 9
                                      ? infant++
                                      : infant = infant;
                                  passengers =
                                  "${adult} Adult, ${child} Child, ${infant} Infant";
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.plus,
                                size: 20,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      color: Colors.black12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select a Class",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: orientation == "portrait" ? screenSize.width/20 : screenSize.height/20,
                                fontFamily: 'Metropolis',
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Wrap(
                        spacing: 10,
                        children: List.generate(_choicesList.length, (index) {
                          return Container(
                            height: 50,
                            child: ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              labelPadding: EdgeInsets.all(2.0),
                              label: Text(
                                _choicesList[index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.white, fontSize: orientation == "portrait" ? screenSize.width/26 : screenSize.height/26,),
                              ),
                              selected: defaultChoiceIndex == index,
                              selectedColor: Color(0xff92278f),
                              onSelected: (value) {
                                setState(() {
                                  defaultChoiceIndex =
                                      value ? index : defaultChoiceIndex;
                                  print(_choicesList[index]);
                                  print(index);
                                  defaultChoiceIndex = index;
                                  planeClassName = _choicesList[index];
                                });
                              },
                              elevation: 0,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: screenSize.width / 2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 4),
                                  blurRadius: 5.0)
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
                              Get.to(Dashboard());
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 20.0),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: StadiumBorder(),
                            ),
                            child: Text(
                              "OK",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
