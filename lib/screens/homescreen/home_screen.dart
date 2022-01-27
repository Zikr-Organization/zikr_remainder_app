import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/ZikrCategoryScreen.dart';

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
          tabBarTheme: const TabBarTheme(
                //backgroundColor: Color(0xff040722),
                labelColor: Color(0xff8b7b52),
                labelStyle: TextStyle(color: Color(0xff8b7b52)), // color for text
                indicator: UnderlineTabIndicator( // color for indicator (underline)
                    borderSide: BorderSide(color: Color(0xff8b7b52)),
                ),
            ),


          // Define the default font family.
        //  fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
     /*     textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: Color(0xff544721)),
            headline6: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Color(0xff8b7b52)),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind', color: Color(0xffd5c296)),
          ),*/
        ),
      home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book)),
              Tab(icon: Icon(Icons.edit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: const Text('Zikr Reminder'),
        ),
        body: const TabBarView(
          children: [
            ZikrCategoryScreen(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    ),
    );
  }
}
