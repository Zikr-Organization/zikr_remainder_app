import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider with ChangeNotifier{
  late final SharedPreferences _preferences;

  Future init() async{
    _preferences = await SharedPreferences.getInstance();
  }

  String getColorOf(String id){
    return _preferences.getString(id) ?? '';
  }

}

