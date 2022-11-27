import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../Models/http_exception.dart';
import '../Models/quiz.dart';

class DBProvider {
  final String date = '05-11-22';
  final String DBurl = 'https://geo-quiz-nb-default-rtdb.firebaseio.com/';

  Future<Quiz> getQuiz() async {
    final String url = DBurl + '/' + date;
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    var quiz = Quiz(data['question'], data['answer']);
    print(quiz);
    return quiz;
  }
}
