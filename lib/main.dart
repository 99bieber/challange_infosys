// ignore_for_file: dead_code

import 'package:challange_infosys/page/dashboard_page.dart';
import 'package:challange_infosys/page/login_page.dart';
import 'package:challange_infosys/page/main_page.dart';
import 'package:challange_infosys/page/splash_page.dart';
import 'package:challange_infosys/providers/auth_provider.dart';
import 'package:challange_infosys/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future getId() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getInt('id');
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProviders()),
        ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Flutter Challange",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                  child: SplashScreen(), type: PageTransitionType.fade);
              break;
            case '/login-page':
              return PageTransition(
                  child: LoginPage(), type: PageTransitionType.fade);
              break;
            case '/main-page':
              return PageTransition(
                  child: MainPage(), type: PageTransitionType.fade);
              break;
            case '/dashboard-page':
              return PageTransition(
                  child: DashboardPage(), type: PageTransitionType.fade);
              break;
            default:
              return null;
          }
        },
        home: FutureBuilder(
          future: getId(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const Scaffold(
                body: MainPage(),
              );
            } else {
              return const Scaffold(
                body: SplashScreen(),
              );
            }
          },
        ),
      ),
    );
  }
}
