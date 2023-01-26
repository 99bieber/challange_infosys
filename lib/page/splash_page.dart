// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';

import 'package:challange_infosys/page/login_page.dart';
import 'package:challange_infosys/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

bool checkId = false;
var id = '';

class _SplashScreenState extends State<SplashScreen> {
  void getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    id = pref.getInt('id').toString();
    if (id != 'null') {
      checkId = true;
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushNamed(context, '/login-page');
      });
    }
  }

  @override
  void initState() {
    getId();
    // print('tes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/header-splash.png',
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/footer-splash.png',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
            ),
          )
        ],
      )),
    );
  }
}
