import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/models/zikr_model.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';
import 'package:characters/characters.dart';

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
        title: Text(widget.zikrCategory.title),
      ),
      body: FutureBuilder<List<ZikrHadeeth>>(
        future: getZikrList(widget.zikrCategory.id),
        builder: (_, snap) {
          final data = snap.data;
          print(data);
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

class ZikrDetailsRow extends StatelessWidget {
  const ZikrDetailsRow(
      {required this.context,
      required this.zikrHadeeth,
      required this.isTranslated,
      required this.isPlaying,
      required this.counter,
      required this.isTranslatedPressed,
      required this.isPlayingPressed,
      required this.isCounterPressed});
  final BuildContext context;
  final ZikrHadeeth zikrHadeeth;

  final bool isTranslated;
  final bool isPlaying;
  final int counter;

  final VoidCallback isTranslatedPressed;
  final VoidCallback isPlayingPressed;
  final VoidCallback isCounterPressed;

  List<Widget> _getTextColumn(bool isTranslated) {
    List<Widget> widgetArray = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          zikrHadeeth.arabicText,
          style: TextStyle(
            fontFamily: 'Amiri',
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
      ),
      Divider(),
    ];
    if (isTranslated) {
      widgetArray.addAll([
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            zikrHadeeth.francoArabic,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            zikrHadeeth.translation,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        Divider(),
      ]);
    }
    widgetArray
        .add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      IconButton(
        icon: Image.asset('images/icons8-globe-100-4.png'),
        iconSize: 30,
        onPressed: () {
          isTranslatedPressed();
        },
      ),
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: 3.0, color: Color(0xff8b7b52)),
          shape: const CircleBorder(
            side: BorderSide(),
          ),
          minimumSize: Size(100.0, 100.0),
        ),
        //style: ButtonStyle(shape: CircleBorder(side: BorderSide(color: Color(0xff8b7b52), width: 3.0))),
        onPressed: () {
          isCounterPressed();
        },
        child: Text(
          "${zikrHadeeth.repeat} \\ ${counter}",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      IconButton(
        icon: Image.asset(!isPlaying
            ? 'images/icons8-circled-play-100.png'
            : 'images/icons8-pause-button-100.png'),
        iconSize: 30,
        onPressed: () {
          isPlayingPressed();
        },
      ),
    ]));
    return widgetArray;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          decoration: BoxDecoration(
            color: Color(0x20ffffff),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          //color: Color(0x11ffffff),

          child: Column(
            children: _getTextColumn(this.isTranslated),
          )),
    );
  }
}
