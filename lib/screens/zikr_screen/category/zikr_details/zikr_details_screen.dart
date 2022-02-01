import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/models/zikr_model.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';
import 'package:zikr_remainder_app/screens/zikr_screen/category/zikr_details/zikr_details_row.dart';
//import 'package:characters/characters.dart';

class ZikrDetails extends StatefulWidget {
  const ZikrDetails({required this.zikrCategory});
  final ZikrCategory zikrCategory;
  @override
  _ZikrDetailsState createState() => _ZikrDetailsState();
}

class _ZikrDetailsState extends State<ZikrDetails> {
  List<bool> isTranslatedArray = [];
  int? isPlayingIndex = null;
  List<int> counters = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.zikrCategory.title,maxLines: 2,textAlign: TextAlign.center,),
      ),
      body: FutureBuilder<List<ZikrHadeeth>>(
        future: getZikrList(widget.zikrCategory.id),
        builder: (_, snap) {
          final data = snap.data;
          //print(data);
          if (data == null) {
            return const Loading();
          }
          if (isTranslatedArray.isEmpty) {
            isTranslatedArray = List<bool>.filled(data.length, false);
            counters = List<int>.filled(data.length, 0);
          }
          return ListView.builder(
            itemBuilder: (_, i) => InkWell(
              child: ZikrDetailsRow(
                context: this.context,
                zikrHadeeth: data[i],
                isTranslated: isTranslatedArray[i],
                isPlaying: (isPlayingIndex == i),
                counter: counters[i],
                isTranslatedPressed: () {
                  setState(() {
                    isTranslatedArray[i] = !isTranslatedArray[i];
                  });
                },
                isPlayingPressed: () {
                  setState(() {
                    (isPlayingIndex != i) ? (isPlayingIndex = i) : (isPlayingIndex = null);
                  });
                },
                isCounterPressed: () {
                  if (counters[i] < data[i].repeat) {
                    setState(() {
                      counters[i] += 1;
                    });
                  }
                },
              ),
            ),
            itemCount: data.length,
          );
        },
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
    );
  }
}
