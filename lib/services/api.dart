import 'dart:convert';
import 'dart:io';

import 'package:flutter_coffee_shop/services/app_exception.dart';
import 'package:flutter_coffee_shop/services/user_helper.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> post(dynamic url, dynamic payload) async {
    var token = UserHelper().getToken();
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: payload,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(dynamic url, dynamic payload) async {
    var token = UserHelper().getToken();
    var responseJson;

    try {
      final response = await http.patch(
        Uri.parse(url),
        body: payload,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> get(dynamic url) async {
    var token = UserHelper().getToken();
    var responseJson;

    try {
      final response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(dynamic url) async {
    var token = UserHelper().getToken();
    var responseJson;

    try {
      final response = await http.delete(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
