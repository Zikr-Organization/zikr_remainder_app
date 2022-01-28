import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/models/zikr_model.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';

class ZikrDetails extends StatefulWidget {
  const ZikrDetails({required this.zikrCategory});
  final ZikrCategory zikrCategory;
  @override
  _ZikrDetailsState createState() => _ZikrDetailsState();
}

class _ZikrDetailsState extends State<ZikrDetails> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hisn-ul-muslim',
      home: Scaffold(
        body: FutureBuilder<List<ZikrCondition>>(
          future: getZikrList(widget.zikrCategory.id),
          builder: (_, snap) {
            final data = snap.data;
            print(data);
            if (data == null) {
              return const Loading();
            }
            return ListView.builder(
              itemBuilder: (_, i) => InkWell(
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Text(data[i].arabicText),
                      Text(data[i].translation),
                      Text(data[i].francoArabic),
                    ],
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
}
