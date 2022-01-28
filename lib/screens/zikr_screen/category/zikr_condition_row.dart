import 'package:flutter/material.dart';
class ZikrConditionRow extends StatelessWidget {
  const ZikrConditionRow(
      {required this.isPreferd,
        required this.title,
        required this.hasAlarm,
        this.alarmSet = null,
        required this.isPreferedPressed,
        required this.isAlarmPressed});
  final bool isPreferd;
  final String title;
  final bool hasAlarm;
  final String? alarmSet;

  final VoidCallback isPreferedPressed;
  final VoidCallback isAlarmPressed;

  List<Widget> getRowChildren() {
    List<Widget> children = [
      Expanded(
        flex: 5,
        child: IconButton(
          icon: Image.asset(isPreferd
              ? 'images/love-marked.png'
              : 'images/love-not-marked.png'),
          iconSize: 50,
          onPressed: () {
            isPreferedPressed();
          },
        ),
      ),
      Expanded(
        flex: 16,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              decoration: TextDecoration.none),
        ),
      ),
    ];
    if (this.hasAlarm && this.alarmSet == null) {
      children.add(Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('images/alarm-clock.png'),
              iconSize: 30,
              onPressed: () {
                isAlarmPressed();
              },
            ),
          ],
        ),
      ));
    } else if (this.hasAlarm && this.alarmSet != null) {
      children.add(
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                alarmSet!,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8b7b52),
                    decoration: TextDecoration.none),
              ),
              IconButton(
                icon: Image.asset('images/alarm-clock.png'),
                iconSize: 30,
                onPressed: () {
                  isAlarmPressed();
                },
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
