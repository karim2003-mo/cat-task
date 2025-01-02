import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class LocalData{
  bool is_key_exist(String key){
    SharedPreferences.getInstance().then((prefs){
      return prefs.containsKey(key);
    });
    return false;
  }
  Future add_data(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> allPrefs = prefs.getKeys().fold<Map<String, dynamic>>({}, (map, key) {
      map[key] = prefs.get(key); // Get the value for each key
      return map;
    });
    print(allPrefs.length);
    if(prefs.containsKey(key)){
    String data= prefs.getString(key)!;
    Map<String,dynamic> local =jsonDecode(data);
    Map<String,dynamic> received =jsonDecode(value);
    print(local['data']['date']['gregorian']['date']==received['data']['date']['gregorian']['date']);
    if(local['data']['date']['gregorian']['date']==received['data']['date']['gregorian']['date']){
      return ;
    }
    }
    prefs.setString(key, value);
  }
  Future<String?> get_data(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> remove_data(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}