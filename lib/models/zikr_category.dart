import 'package:zikr_remainder_app/models/zikr_model.dart';
import 'package:zikr_remainder_app/repository/api.dart';

class ZikrCategory {
  int id;
  String title;

  ZikrCategory.fromJson(Map<String, dynamic>data): id = data['ID'], title=data['TITLE'];

  Future<List<Zikr>> get zikrList async{
    return getZikrList(id);
  }

  @override
  String toString() {
    return 'ZikrCategory{id: $id, title: $title}';
  }
}