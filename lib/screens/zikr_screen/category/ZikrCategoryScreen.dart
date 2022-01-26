import 'package:flutter/material.dart';
import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:zikr_remainder_app/repository/api.dart';
import 'package:zikr_remainder_app/screens/widgets/loading.dart';

class ZikrCategoryScreen extends StatelessWidget {
  const ZikrCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zikr Categories Test'),),
      body: FutureBuilder<List<ZikrCategory>>(
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
                color: i % 2 == 0 ? Colors.grey.withOpacity(0.5) : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(data[i].title),
                ),
              ), //todo rewrite UI here
            ),
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
