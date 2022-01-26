import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:zikr_remainder_app/provider/PreferenceProvider.dart';
import 'package:zikr_remainder_app/screens/homescreen/home_screen.dart';

main() async {
  final pref = PreferenceProvider();
  runApp(ChangeNotifierProvider.value(
    value: pref,
    child: const HomeScreen(),
  ));
}
