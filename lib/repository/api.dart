import 'dart:convert';

import 'package:zikr_remainder_app/models/zikr_category.dart';
import 'package:http/http.dart' as http;
import 'package:zikr_remainder_app/models/zikr_model.dart';

const HISNAL_MUSLIM_API_BASE = 'http://www.hisnmuslim.com/api/en/';

main() async {
  final val = await getZikrList(27);
  val.forEach((element) {
    print(element);
  });
}

Future<List<ZikrCategory>> get allZikrCategories async {
  final data = await getDataFromAPI(HISNAL_MUSLIM_API_BASE + 'husn_en.json');
  return (data['English'] as List<dynamic>)
      .map((e) => ZikrCategory.fromJson(e))
      .toList();
}

Future<List<Zikr>> getZikrList(int id) async {
  final data = await getDataFromAPI(HISNAL_MUSLIM_API_BASE + '$id.json');
  return ((data.values.first as List<dynamic>).map((e) => Zikr.fromJson(e)).toList());
}

Future<Map<String, dynamic>> getDataFromAPI(String url) async {
  final res = await http.Client().get(Uri.parse(url));
  return jsonDecode(res.body.replaceAll('ï»¿', ''));
}
