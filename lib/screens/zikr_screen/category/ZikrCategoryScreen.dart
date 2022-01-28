import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';

class ZikrCategoryScreen extends StatefulWidget {
  const ZikrCategoryScreen({Key? key}) : super(key: key);

  @override
  _ZikrCategoryScreenState createState() => _ZikrCategoryScreenState();
}

class _ZikrCategoryScreenState extends State<ZikrCategoryScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zikr Categories Test',
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/vector-1-background.jpg"),
                fit: BoxFit.cover)),
        //child: Text("Allah"),
   //     child: Scaffold(
   //       backgroundColor: Colors.transparent,
   //       appBar: AppBar(
  //          elevation: 0,
  //          backgroundColor: Colors.transparent,
  //        ),
          //   appBar: AppBar(title: Text('Zikr Categories Test'),),
          child: FutureBuilder<List<ZikrCategory>>(
            future: allZikrCategories,
            builder: (_, snap) {
              final data = snap.data;
              if (data == null) {
                return const Loading();
              }
              return ListView.builder(
                itemBuilder: (_, i) => InkWell(
                  onTap: () {
                    //navigate to details screen
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ZikrConditionRow(
                          isPreferd: false,
                          title: data[i].title,
                          hasAlarm: (data[i].id == 27 || data[i].id == 28 || data[i].id == 1),
                          //alarmSet: '08:00',
                        ), //Text(data[i].title),
                        ),
                  ),
                ),
                itemCount: data.length,
              );
            },
          ),
       // ),
      ),
    );
  }
}

class ZikrConditionRow extends StatelessWidget {
  const ZikrConditionRow(
      {required this.isPreferd, required this.title, required this.hasAlarm, this.alarmSet = null});
  final bool isPreferd;
  final String title;
  final bool hasAlarm;
  final String? alarmSet;

  List<Widget> getRowChildren() {
    List<Widget> children = [
    Expanded(
    flex: 5,
    child: IconButton(
    icon: Image.asset(isPreferd
    ? 'images/love-marked.png'
        : 'images/love-not-marked.png'),
    iconSize: 50,
    onPressed: () {},
    ),
    ),
    Expanded(
    flex: 16,
    child: Text(
    title,
    style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Colors.white, decoration: TextDecoration.none),

    ),
    ),

    ];
    if (this.hasAlarm && this.alarmSet == null){
      children.add(Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('images/alarm-clock.png'),
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ))
      ;
    }
    else if (this.hasAlarm && this.alarmSet != null){
      children.add(Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(alarmSet!, style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Color(0xff8b7b52), decoration: TextDecoration.none),),
            IconButton(
              icon: Image.asset('images/alarm-clock.png'),
              iconSize: 30,
              onPressed: () {},
            ),
        ],
         ),
      ),
    );
    }
    return children;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getRowChildren(),
          ),
    );
  }
}
