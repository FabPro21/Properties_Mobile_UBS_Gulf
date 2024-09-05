import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalPreferencesLabels {
  static String loginToken = "4E7Bg";
  static String phoneNumber = "jpPnx";
  static String userName = "5J8mC";
  static String userNameAr = "r5d6y";
  static String isLoginBool = "05zpm";
  static String fingerPrint = "LpkDI";
  static String deviceToken = "Apk3I";
  static String blockTime = "Pme4Q";
  static String isBlocked = "Lxk9P";
  static String isEnglish = "RvS3L";
  static String setLanguage = "0Lk3V";
  static String langId = "KcW2t";
  static String userID = "KcW2t2310";
  static String videoTutorail = "KcW2t1032";
}

class GlobalPreferences {
  static getInt(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(key) ?? 0;
    return value;
  }

  static setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static getBool(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool(key) ?? false;
    return value;
  }

  static setbool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static setClear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static remove(key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}

EncryptedSharedPreferences encryptedSharedPreferences =
    EncryptedSharedPreferences(mode: AESMode.sic);

class GlobalPreferencesEncrypted {
  static setString(String key, String value) async {
    encryptedSharedPreferences.setString(key, value);
  }

  static getString(key) async {
    String val = await encryptedSharedPreferences.getString(key);
    return val;
  }

  static clearValues() async {
    await encryptedSharedPreferences.clear();
  }
}
