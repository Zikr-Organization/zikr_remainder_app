import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/zikr_category_screen.dart';
import 'package:zikr_remainder_app/screens/azker_screen/azker_screen.dart';
import 'package:zikr_remainder_app/screens/channels_screen/channels_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Zikr Reminder',
        theme: ThemeData(
          // Define the default brightness and colors.
         // brightness: Brightness.dark,
          primaryColorDark: Color(0xff040722),
          primaryColor: Color(0xff212e54),
          primaryColorLight: Color(0xff314879),
          appBarTheme: const AppBarTheme(
            color: Color(0xff040722),
            foregroundColor: Color(0xff8b7b52)

          ),
          //colorScheme: ColorScheme(secondary: Color(0xff8b7b52), brightness: ),
          tabBarTheme: const TabBarTheme(
                //backgroundColor: Color(0xff040722),
                labelColor: Color(0xff8b7b52),
                labelStyle: TextStyle(color: Color(0xff8b7b52)), // color for text
                indicator: UnderlineTabIndicator( // color for indicator (underline)
                    borderSide: BorderSide(color: Color(0xff8b7b52)),
                ),
            ),
          dialogTheme: const DialogTheme(backgroundColor: Color(0xff314879)),


          // Define the default font family.
          fontFamily: 'AbrilFatface',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
           // headline1: TextStyle(fontSize: 96.0, fontWeight: FontWeight.bold, color: Color(0xff544721)),
          //  headline2: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Color(0xff544721)),
          //  headline3: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold, color: Color(0xff8b7b52)),
            headline4: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Color(0xff544721)),
            headline5: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xff544721)),
            headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),//20.0
            bodyText1: TextStyle(fontSize: 17.0, fontFamily: 'Amiri', color: Colors.white),
            bodyText2: TextStyle(fontSize: 15.0, fontFamily: 'Amiri', color: Color(0xffd5c296)),
          ),
        ),
      home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book_rounded)),
              Tab(icon: Icon(Icons.edit_rounded)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: const Text('Zikr Reminder',style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold, color: Color(0xff8b7b52))),
        ),
        body: const TabBarView(
          children: [
            ZikrCategoryScreen(),
            AzkerScreen(),
            ChannelsScreen(),
          ],
        ),
      ),
    ),
    );
  }
}
