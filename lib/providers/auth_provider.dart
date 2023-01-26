import 'dart:ffi';

import 'package:challange_infosys/services/auth_services.dart';
import 'package:flutter/cupertino.dart';

import '../models/profile_model.dart';

class AuthProviders with ChangeNotifier {
  UserModel _user = UserModel();

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> login({
    String? username,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        username: username,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getUser({
    String? id,
  }) async {
    try {
      UserModel user = await AuthService().getUser(
      id:id);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
