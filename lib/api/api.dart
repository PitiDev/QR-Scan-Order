import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiApp {
  final String _url = 'http://127.0.0.1:8000/api/';

  postURL(data, apiUrl) {
    var fullUrl = _url + apiUrl;
    return http.post(fullUrl, body: data);
  }

  getURL(apiUrl) {
    var fullUrl = _url + apiUrl;
    return http.get(fullUrl);
  }
}
