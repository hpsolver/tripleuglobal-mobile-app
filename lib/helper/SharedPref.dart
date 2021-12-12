import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static const USER_ID="user_id";
  static const USER_TYPE="user_type";
  static const FIRST_NAME="first_name";
  static const LAST_NAME="last_name";
  static const EMAIL="email";
  static const PHONE_NUMBER="phoneNumber";


  static void  addStringToSF(String name,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }


  static Future<String?> getStringFromSF(String name) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getString(name);
  }


  static clearSharePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}
