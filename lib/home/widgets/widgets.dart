import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_badge/icon_badge.dart';
import 'dart:math' as math;

Widget header() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome  User',
                style: TextStyle(
                  color: Color(0xFF070707).withOpacity(0.9),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Where do',
                style: TextStyle(
                  color: Color(0xFF000000).withOpacity(0.6),
                  fontSize: 22,
                ),
              ),
              //const SizedBox(height: 4),
              const Text(
                'you want to go?',
                style: TextStyle(
                  color: Color(0xFF0E0E0E),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          backgroundColor: Color(0x57e147dd),
          radius: 26,
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
        ),
      ],
    ),
  );
}

Widget searchBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        width: 225,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff92278f), Color(0xbeccd3ff)],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x93000000),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
            borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextFormField(
              //controller: searchController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: Color(0xffffffff),
                  ),
                  onPressed: () async {
                    // searchController.clear();
                    // await getbookcatogerywise(isRefresh: true);
                  },
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xffffffff),
                ),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onChanged: (value) async {
                //await getbookcatogerywise(isRefresh: true);
              },
            ),
          ),
        ),
      ),
      Container(
        child: IconBadge(
          icon: Icon(
            Icons.notifications_none,
            size: 40,
            color: Colors.black,
          ),
          itemCount: 5,
          badgeColor: Colors.red,
          itemColor: Colors.white,
          hideZero: true,
          onTap: () {
            print('test');
          },
        ),
      )
    ],
  );
}

Widget hotDestinationCard(String imagePath, String placeName,
    String touristPlaceCount, BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation.name;
  return GestureDetector(
    onTap: () => {
      print(placeName),
    },
    child: Stack(children: [
      Hero(
        tag: imagePath,
        child: Container(
          height: 200,
          width: 140,
          margin: EdgeInsets.only(right: 25),
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          height: 200,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  Color(0xcb250d2f), Colors.transparent
                  // Color(0xFFFFFF)
                ]),
          ),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                placeName,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: orientation == "portrait" ? screenSize.width/27 : screenSize.height/27,
                    color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                touristPlaceCount,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: orientation == "portrait" ? screenSize.width/36 : screenSize.height/36,
                    color: Colors.white),
              ),
            ]),
      ),
    ]),
  );
}

Widget topWidget(double screenWidth) {
  return Transform.rotate(
    angle: 50 * math.pi / 160,
    child: Container(
      width: 1.2 * screenWidth,
      height: 1.2 * screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(300),
        gradient: const LinearGradient(
          begin: Alignment(-0.5, -0.8),
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF92278F),
            Color(0xFF92278F),
          ],
        ),
      ),
    ),
  );
}

Widget bottomWidget(double screenWidth) {
  return Container(
    width: 1.5 * screenWidth,
    height: 1.5 * screenWidth,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment(0.6, -1.1),
        end: Alignment(0.7, 0.8),
        colors: [
          Color(0xFF92278F),
          Color(0x10F04E6E),
        ],
      ),
    ),
  );
}
