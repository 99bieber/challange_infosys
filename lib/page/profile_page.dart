import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/profile_model.dart';
import '../providers/auth_provider.dart';
import '../shared/theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProviders authProvider = Provider.of<AuthProviders>(context);
    UserModel profile = authProvider.user;

    Widget buttonSubmit() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        width: 200,
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: c1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            final success = await pref.remove('id');
            Navigator.pushNamedAndRemoveUntil(
                context, '/login-page', (route) => false);
          },
          child: Text(
            'Log Out',
            style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget header() {
      return Container(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: c3),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          profile.image.toString(),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: c3TextStyle.copyWith(fontWeight: bold, fontSize: 24),
                  ),
                  Text(
                    '${profile.email}',
                    style: c3TextStyle.copyWith(fontSize: 18),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [header(), buttonSubmit()],
    ));
  }
}
