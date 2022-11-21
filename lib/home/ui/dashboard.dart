import 'package:dtrip_login/home/ui/account/profile_page.dart';
import 'package:dtrip_login/home/ui/place/places_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'deals/deals_page.dart';
import 'flight/flight_book_page.dart';
import 'home/home_page.dart';
import 'hotel/hotel_book_page.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}



PersistentTabController _controller = PersistentTabController(initialIndex: 0);
List<Widget> _buildScreens() {
  return [
    MyHomePage(restorationId: 'main'),
    DealsPage(),
    PlacesPage(),
    UserProfilePage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
     // icon: Image.asset('assets/images/icons/house.png'),
      icon: Icon(Ionicons.home_outline),

      iconSize: 24,
      textStyle: TextStyle(
        fontSize: 12,
        fontFamily: "Metropolis"
      ),
      title: ("Home"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
    PersistentBottomNavBarItem(
      icon: ImageIcon(AssetImage('assets/images/icons/deals.png')),
      // icon: Icon(Ionicons.bed_outline),
      iconSize: 24,
      textStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis"
      ),
      title: ("Deals"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
    PersistentBottomNavBarItem(
      //icon: Image.asset('assets/images/icons/plane.png'),
      icon: Icon(Ionicons.location_outline),
      iconSize: 24,
      textStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis"
      ),
      title: ("Places"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
    PersistentBottomNavBarItem(
     // icon: Image.asset('assets/images/icons/user.png'),
      icon: Icon(Ionicons.person_outline),
      iconSize: 24,
      textStyle: TextStyle(
          fontSize: 12,
          fontFamily: "Metropolis"
      ),
      title: ("Account"),
      activeColorPrimary: Color(0xff92278f),
      inactiveColorPrimary: Color(0xffd3a9d2),
    ),
  ];
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(0xffffffff),
      // backgroundColor: Color(0xffc993c7), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(20.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      padding: NavBarPadding.all(5),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarHeight: 56,
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
