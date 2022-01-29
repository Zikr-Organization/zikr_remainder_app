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

Future<List<ZikrHadeeth>> getZikrList(int id) async {
  final data = await getDataFromAPI(HISNAL_MUSLIM_API_BASE + '$id.json');
  return ((data.values.first as List<dynamic>).map((e) => ZikrHadeeth.fromJson(e)).toList());
}

Future<Map<String, dynamic>> getDataFromAPI(String url) async {
  if (url == HISNAL_MUSLIM_API_BASE + 'husn_en.json'){
    final res = await http.Client().get(Uri.parse(url));

    return jsonDecode(res.body.replaceAll('ï»¿', ''));
  }
  else{
    final res = await http.Client().get(Uri.parse(url));
    ///first decode the response to utf-8 string
    var myDataString = utf8.decode(res.bodyBytes);
    ///obtain json from string
    var myDataJson = jsonDecode(myDataString);
    return myDataJson;
  }
}
