import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/ZikrCategoryScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ZikrCategoryScreen()
    );
  }
}
