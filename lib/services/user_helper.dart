import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  Future setToken(String val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('token', val);
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token');
  }

  Future setUserId(int val) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setInt('userId', val);
  }

  Future<int?> getUserId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt('userId');
  }

  Future logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }
}
