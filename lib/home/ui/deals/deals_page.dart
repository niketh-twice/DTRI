import 'package:flutter/material.dart';

class DealsPage extends StatefulWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  State<DealsPage> createState() => _DealsPageState();
}

class _DealsPageState extends State<DealsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Deals"),
      ),
    );
  }
}
