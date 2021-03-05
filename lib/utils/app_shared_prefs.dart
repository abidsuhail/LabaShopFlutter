import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs
{
  static const String AUTH_TOKEN = 'authtoken';
  static Future<SharedPreferences> getInstance() async => await SharedPreferences.getInstance();

  static void saveAuthToken(String authToken) async
  {
    (await getInstance()).setString(AUTH_TOKEN, authToken);
  }
  static Future<String> getAuthToken() async
  {
    SharedPreferences prefs = (await getInstance());
    return prefs.containsKey(AUTH_TOKEN)?prefs.getString(AUTH_TOKEN):'';
  }

  static Future<bool> removeAllPrefs() async{
    SharedPreferences prefs = (await getInstance());
    return await prefs.clear();
  }
}