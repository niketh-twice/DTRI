// import 'dart:math';
//
// import 'package:dtrip_login/home/ui/dashboard.dart';
// import 'package:dtrip_login/login/login_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//   int _currentIndex = 0;
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     var orientation = MediaQuery.of(context).orientation.name;
//     var screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       body: Stack(
//         children: [
//           CustomPaint(
//             painter: ArcPainter(),
//             child: SizedBox(
//               height: screenSize.height / 1.4,
//               width: screenSize.width,
//             ),
//           ),
//           Positioned(
//             top: 100,
//             right: 20,
//             left: 20,
//             child: SizedBox(
//               height: 250,
//               child: OverflowBox(
//                 minHeight: 370,
//                 maxHeight: 370,
//                 child: Lottie.asset(
//                   tabs[_currentIndex].lottieFile,
//                   key: Key('${Random().nextInt(999999999)}'),
//                   width: 100,
//                   alignment: Alignment.topCenter,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SizedBox(
//               height: 270,
//               child: Column(
//                 children: [
//                   Flexible(
//                     child: PageView.builder(
//                       controller: _pageController,
//                       itemCount: tabs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         OnboardingModel tab = tabs[index];
//                         return Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               tab.title,
//                               style: const TextStyle(
//                                 fontSize: 27.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 50),
//                             Text(
//                               tab.subtitle,
//                               style: const TextStyle(
//                                 fontSize: 17.0,
//                                 color: Colors.black87,
//                               ),
//                               textAlign: TextAlign.center,
//                             )
//                           ],
//                         );
//                       },
//                       onPageChanged: (value) {
//                         setState(() {
//                           _currentIndex = value;
//                         });
//                       },
//                     ),
//                   ),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       for (int index = 0; index < tabs.length; index++)
//                         _DotIndicator(isSelected: index == _currentIndex),
//                     ],
//                   ),
//                   const SizedBox(height: 75)
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           if (_currentIndex == 2) {
//             Get.to(LoginPage());
//           } else {
//             _pageController.nextPage(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.linear,
//             );
//           }
//         },
//         child: const Icon(CupertinoIcons.chevron_right, color: Colors.white),
//         backgroundColor: Color(0xff92278f),
//       ),
//     );
//   }
// }
//
// class ArcPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path orangeArc = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height - 170)
//       ..quadraticBezierTo(
//           size.width / 2, size.height, size.width, size.height - 170)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();
//
//     canvas.drawPath(orangeArc, Paint()..color = Colors.purple);
//
//     Path whiteArc = Path()
//       ..moveTo(0.0, 0.0)
//       ..lineTo(0.0, size.height - 185)
//       ..quadraticBezierTo(
//           size.width / 2, size.height - 70, size.width, size.height - 185)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width, 0)
//       ..close();
//
//     canvas.drawPath(whiteArc, Paint()..color = Colors.white);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
//
// class _DotIndicator extends StatelessWidget {
//   final bool isSelected;
//
//   const _DotIndicator({Key? key, required this.isSelected}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 6.0),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         height: 6.0,
//         width: 6.0,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: isSelected ? Color(0xff92278f) : Color(0xffe8c2e7),
//         ),
//       ),
//     );
//   }
// }
//
// class OnboardingModel {
//   final String lottieFile;
//   final String title;
//   final String subtitle;
//
//   OnboardingModel(this.lottieFile, this.title, this.subtitle);
// }
//
// List<OnboardingModel> tabs = [
//   OnboardingModel(
//     'assets/lottie/travel.json',
//     'Travel Around The World',
//     'Jobs fill your pockets, adventures fill your soul.\nRemember that happiness is a way of travel,\nnot a destination.',
//   ),
//   OnboardingModel(
//     'assets/lottie/hotel.json',
//     'Discover The Best Hotels',
//     'We make it simple to find the \nhotels of your likes. \nFind the best suites for you.',
//   ),
//   OnboardingModel(
//     'assets/lottie/travel-plane.json',
//     'Fly Around The Globe',
//     'We make it easy to find your flights ,\n Book tickets and\n fly to your favourite places.',
//   ),
// ];
