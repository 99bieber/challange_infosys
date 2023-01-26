import 'package:challange_infosys/page/dashboard_page.dart';
import 'package:challange_infosys/page/profile_page.dart';
import 'package:challange_infosys/shared/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Widget customBottomNavbar() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            // print(currentIndex);
            setState(() {
              currentIndex = value;
            });
          },
          selectedItemColor: c7,
          unselectedItemColor: c6,
          backgroundColor: c3,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Profile',
            )
          ],
        ),
      );
    }

    const List<Widget> _widgetOptions = <Widget>[
      DashboardPage(),
      ProfilePage()
    ];

    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          backgroundColor: c7,
            bottomNavigationBar: customBottomNavbar(),
            body: Center(
              child: _widgetOptions.elementAt(currentIndex),
            )),
      ),
    );
  }
}
