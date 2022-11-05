import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Models/http_exception.dart';


class Auth with ChangeNotifier {
  late String _authToken;
  late String _userId;
  late DateTime _expiryData;

  bool get isAuth {
    return null != token;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryData != null &&
        _expiryData.isAfter(DateTime.now()) &&
        _authToken != null) {
      return _authToken;
    }
    return 'null';
  }

  Future<void> signUp(String email, String password) async {
    const String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyB7CpF4EqTvZIQa24qa_bVxiIRlQduBUxM';
    try {
      final request = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseDate = json.decode(request.body);
      if (responseDate['error'] != null) {
        throw new HttpException(
            'An error occurred, ${responseDate['error']['message']}');
      }
    } on HttpException catch (error) {
      throw error;
    } catch (error) {
      rethrow;
    }
    signIn(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    const String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyB7CpF4EqTvZIQa24qa_bVxiIRlQduBUxM';
    try {
      final request = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      final responseDate = json.decode(request.body);
      if (responseDate['error'] != null) {
        throw HttpException(
            'An error occurred, ${responseDate['error']['message']}');
      } else {
        _authToken = responseDate['idToken'];
        _userId = responseDate['localId'];
        _expiryData = DateTime.now()
            .add(Duration(seconds: int.parse(responseDate['expiresIn'])));
      }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }

  void logout(){
    _authToken = 'null';
    _expiryData = DateTime(0);
    _userId = 'null';
    notifyListeners();
  }
}
