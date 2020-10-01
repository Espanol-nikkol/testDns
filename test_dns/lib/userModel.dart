import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  String _firstName,
      _lastName,
      _patronymic,
      _phone,
      _email,
      _github,
      _summary,
      _token;

  UserModel();

  final _tokenUrl = "https://vacancy.dns-shop.ru/api/candidate/token";
  final _regUrl = "https://vacancy.dns-shop.ru/api/candidate/summary";

  set token(String v) => _token = v;

  void setPersonalData(
      String firstName,
      String lastName,
      String patronymic,
      String phone,
      String email
      ) {
    _firstName = firstName;
    _lastName = lastName;
    _patronymic = patronymic;
    _phone = phone;
    _email = email;
  }

  void setWorkData(
    String github,
    String summary
      ) {
    _github = github;
    _summary = summary;
  }

  Map get getPersonalData => {
    "firstName" : _firstName,
    "lastName": _lastName,
    "phone": _phone,
    "email": _email
  };

  Map get getFullData => {
    "firstName": _firstName,
    "lastName": _lastName,
    "patronymic": _patronymic,
    "phone": _phone,
    "email": _email,
    "githubProfileUrl": _github,
    "summary": _summary
  };

  Future<void> getToken() async {
    http.Response response = await http.post(
        _tokenUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(this.getPersonalData)
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    switch (responseJson["code"]) {
      case 0:
        this._token = responseJson["data"];
        break;
      default:
        throw Exception(responseJson["message"]);
        break;
    }
  }

  Future<void> reg() async {
    http.Response response = await http.post(
        _regUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer ${this._token}"
        },
        body: json.encode(this.getFullData)
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    switch (responseJson["code"]) {
      case 0:
        break;
      default:
        throw Exception(responseJson["message"]);
        break;
    }
  }
}