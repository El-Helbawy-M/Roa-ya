import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../services/registration/models/user_model.dart';
import '../router/navigator.dart';
import '../router/routes.dart';



abstract class CachingKey{ 
  static String USER = 'USER';
  static String REMEMBER_ME = "REMEMBER_ME";
  static String TOKEN = 'REAL_TOKEN';
  static String IS_LOGIN = 'IS_LOGIN';
  static String SKIP = 'SKIP';
  static String PERSONAL_ID = 'PERSONAL_ID';
  static String SITE_ID = 'SITE_ID';
  static String URL_CODE = 'URL_CODE';
  static String USER_LAT = 'USER_LAT';
  static String USER_LONG = 'USER_LONG';
  static String CHECK_LOCATION = 'CHECK_LOCATION';
  static String ADDRESS = 'ADDRESS';
  static String COUNTRY = 'COUNTRY';
  static String COUNTRY_NAME = 'COUNTRY_NAME';
  static String IS_OPEN_SITTING = 'IS_OPEN_SITTING';
  static String USER_SECOND = 'USER_SECOND';
  static String USER_MINUTE = 'USER_MINUTE';
  static String USER_HOURS = 'USER_HOURS';
  static String FEATURED_KEYWORDS = "FEATURED_KEYWORDS";
}

class SharedHelper {

  static SharedPreferences? shared;
  static SharedHelper? sharedHelper;
  static init() async {
    if(shared == null){
      shared = await SharedPreferences.getInstance();
      sharedHelper = SharedHelper();
    }

  }

  removeData(String key) async {
    shared!.remove(key);
  }

  Future<void> saveUser(UserModel model,{bool remember = false,String? password}) async{
    writeData(CachingKey.TOKEN, model.token);
    writeData(CachingKey.SKIP, true);
    writeData(CachingKey.IS_LOGIN, true);
    writeData(CachingKey.USER , json.encode(model.toJson()));
    print(jsonEncode({"email":remember?model.user!.email:"","id":remember?model.user!.id:""}));
    writeData(CachingKey.REMEMBER_ME, jsonEncode({"email":remember?model.user!.email:"","password":remember?password:""}));
  }

  Future<Map<String,dynamic>> remember() async{
    print(jsonDecode(await shared!.getString(CachingKey.REMEMBER_ME)??"{}"));
    return jsonDecode(await shared!.getString(CachingKey.REMEMBER_ME)??"{}");
  }
  

  Future<UserModel> getUser() async {
    UserModel _user;
    print(jsonDecode(shared!.getString(CachingKey.USER)!));
    _user = UserModel().fromJson(jsonDecode(shared!.getString(CachingKey.USER)!)) as UserModel;
    log('USER INFO >>> ${_user.toJson()}');
    return _user;
  }

  clear() async {
    removeData(CachingKey.TOKEN);
    removeData(CachingKey.SKIP);
    removeData(CachingKey.IS_LOGIN);
    removeData(CachingKey.USER);
    removeData(CachingKey.FEATURED_KEYWORDS);
    // shared!.clear();
  }

  logout() async {
    // String currentLang = await allTranslations.getPreferredLanguage();
    clear();
    CustomNavigator.push(Routes.onboarding, clean: true);
    SharedHelper.sharedHelper!.writeData(CachingKey.SKIP, true);
    // allTranslations.setNewLanguage(currentLang, true);
    // allTranslations.setPreferredLanguage(currentLang);

  }

  Future <void> writeData(String key, value) async {
    log("Saving => $value local => with key ${key}");
    if (value is String) {
      shared!.setString(key, value);
    } else if (value is int) {
      shared!.setInt(key, value);
    } else if (value is bool) {
      shared!.setBool(key, value);
    } else if (value is double) {
      shared!.setDouble(key, value);
    } else if (value is List<String>){
      shared!.setStringList(key, value);
    }
     else {
      return null;
    }
  }

  Future<bool> readBoolean(String key) async {
    return Future.value(shared!.getBool(key) ?? false);
  }

  Future<double> readDouble(String key) async {
    return Future.value(shared!.getDouble(key) ?? 0.0);
  }

  Future<int> readInteger(String key) async {
    return Future.value(shared!.getInt(key) ?? 0);
  }

  Future<String> readString(String key) async {
    return Future.value(shared!.getString(key)?? "");
  }

  Future<List<String>> readListOfString(String key) async {
    return await Future.value(shared!.getStringList(key)??<String>[])as List<String>;
  }

}



