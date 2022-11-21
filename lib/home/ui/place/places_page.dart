import 'package:flutter/material.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Places"
        ),
      ),
    );
  }
}
