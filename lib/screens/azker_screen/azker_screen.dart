import 'package:flutter/material.dart';

class AzkerScreen extends StatelessWidget {
  const AzkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Custom Zikr',
        home: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("images/vector-2-background.jpg"),
    fit: BoxFit.cover)),
        )
    );
  }
}
