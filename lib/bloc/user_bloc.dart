import 'dart:convert';

import 'package:flutter_coffee_shop/services/api.dart';
import 'package:flutter_coffee_shop/services/constants.dart';
import 'package:flutter_coffee_shop/services/user_helper.dart';

import '../models/login.dart';
import '../models/register.dart';

class UserBloc {
  static Future<Register> register(
      {String? nama, String? username, String? password}) async {
    String url = AppConstants.REGISTER_URL;

    var payload = {"nama": nama, "username": username, "password": password};

    var response = await Api().post(url, payload);
    var jsonObj = json.decode(response.body);
    return Register.fromJson(jsonObj);
  }

  static Future<Login> login({String? username, String? password}) async {
    String url = AppConstants.LOGIN_URL;

    var payload = {"username": username, "password": password};

    var response = await Api().post(url, payload);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }

  static Future logout() async {
    await UserHelper().logout();
  }
}
