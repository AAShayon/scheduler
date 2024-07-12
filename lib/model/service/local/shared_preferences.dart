import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService{
  Future<void> write({required String key, required dynamic value});
  Future<dynamic> read({required String key});
  Future<void> delete({required String key});
  Future<void> update({required String key, required dynamic value});
}


class SharedPreService implements StorageService{
  static SharedPreferences? sharedPreferences;
  static final SharedPreService _singleton = SharedPreService._internal();


  factory SharedPreService(){
    return _singleton;
  }
  SharedPreService._internal(){
    setup();
  }
  setup()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  @override
  Future<void> delete ({required String key}) async{
    await sharedPreferences?.remove(key);
  }

  @override
  Future<dynamic> read({required String key}) async {
    return sharedPreferences?.get(key);
  }

  @override
  Future<void> update({required String key,required dynamic value}) async {
    await sharedPreferences?.remove(key);
    await sharedPreferences?.setString(key, value.toString());
  }

  @override
  Future<void> write({required String key,required dynamic value}) async {
    if (value is String) {
      await sharedPreferences?.setString(key, value);
    } else if (value is int) {
      await sharedPreferences?.setInt(key, value);
    } else if (value is bool) {
      await sharedPreferences?.setBool(key, value);
    } else if (value is double) {
      await sharedPreferences?.setDouble(key, value);
    } else if (value is List<String>) {
      await sharedPreferences?.setStringList(key, value);
    } else {
      await sharedPreferences?.setString(key, jsonEncode(value));
    }
  }
}