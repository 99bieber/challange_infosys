// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:challange_infosys/models/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'API/api.dart';

class AuthService {
  Future<UserModel> login({
    String? username,
    String? password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('$baseUrl/auth/login');
    var body = jsonEncode({'username': username, 'password': password});
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel profile = UserModel.fromJson(data);
      prefs.setInt('id', data['id']);
      return profile;
    } else {
      throw Exception('Gagal');
    }
  }

  Future<UserModel> getUser({String? id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    var url = Uri.parse('$baseUrl/users/$id');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel profile = UserModel.fromJson(data);
      prefs.setInt('id', data['id']);
      return profile;
    } else {
      throw Exception('Gagal');
    }
  }
}
