import 'package:flutter/material.dart';

class ChannelsScreen extends StatelessWidget {
  const ChannelsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Custom Zikr',
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/vector-3-background.jpg"),
                  fit: BoxFit.cover)),
        )
    );
  }
}
