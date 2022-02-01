import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/zikr_condition_row.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/zikr_details/zikr_details_screen.dart';

class ZikrCategoryScreen extends StatefulWidget {
  const ZikrCategoryScreen({Key? key}) : super(key: key);

  @override
  _ZikrCategoryScreenState createState() => _ZikrCategoryScreenState();
}

class _ZikrCategoryScreenState extends State<ZikrCategoryScreen> {
  //TimeOfDay selectedTime = TimeOfDay.now();
  var isPreferedArray = List.filled(132, false); //TODO change hardcoded num
  var selectedTimes = Map<int,TimeOfDay>(); //TODO because morning and evening will be splitted
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Hisn-Ul-Muslim", textAlign: TextAlign.center,),
    ),
    body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/vector-1-background.jpg"),
                fit: BoxFit.cover)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ZikrDetails(zikrCategory: data[i])),
                  );//TODO use extentions
                },
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ZikrConditionRow(
                      context: this.context,
                      isPreferd: isPreferedArray[i],
                      title: data[i].title,
                      isPreferedPressed: () {
                        setState(() {
                          isPreferedArray[i] = !isPreferedArray[i];
                        });
                      },
                      hasAlarm: (data[i].id == 270 ||
                          data[i].id == 271 ||
                          data[i].id == 28 ||
                          data[i].id == 1),
                      isAlarmPressed: () {
                        _selectTime(context,i);

                      },
                      alarmSet: ((selectedTimes[i] != null) ? "${selectedTimes[i]?.hour}:${selectedTimes[i]?.minute}" : null),
                    ),
                  ),
                ),
              ),
              itemCount: data.length,
            );
          },
        ),
      ),
    );
  }
  _selectTime(BuildContext context, int index) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if(timeOfDay != null)// && timeOfDay != TimeOfDay.now())
    {
      setState(() {
        selectedTimes[index] = timeOfDay;
      });
      //TODO set notification
    }
  }
}
