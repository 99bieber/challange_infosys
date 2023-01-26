// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:challange_infosys/providers/product_provider.dart';
import 'package:challange_infosys/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool showPasswword = false;
FocusNode usernameFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();
bool isActivePassword = false;
bool isActiveUsername = false;
bool succesLogin = false;
bool isLoading = false;

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    AuthProviders authProvider = Provider.of<AuthProviders>(context);
    Widget usernameInput() {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 29),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: c7,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: usernameFocusNode.hasFocus || isActiveUsername == true
                  ? c3
                  : c6,
            )),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            Icons.person_outline,
            color: usernameFocusNode.hasFocus || isActiveUsername == true
                ? c3
                : c6,
          ),
          Expanded(
              child: GestureDetector(
            child: TextFormField(
              style: TextStyle(
                color: usernameFocusNode.hasFocus || isActiveUsername == true
                    ? c3
                    : c6,
              ),
              focusNode: usernameFocusNode,
              onEditingComplete: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                setState(() {
                  isActiveUsername = false;
                });
              },
              controller: usernameController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration.collapsed(
                hintText: 'Username',
                hintStyle:
                    usernameFocusNode.hasFocus || isActiveUsername == true
                        ? c3TextStyle.copyWith()
                        : c6TextStyle.copyWith(),
              ),
            ),
          ))
        ]),
      );
    }

    Widget passwordInput() {
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 18),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: c7,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: passwordFocusNode.hasFocus || isActivePassword == true
                  ? c3
                  : c6,
            )),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Icon(
            Icons.lock,
            color: passwordFocusNode.hasFocus ? c3 : c6,
          ),
          Expanded(
              child: GestureDetector(
            child: TextFormField(
              style: TextStyle(
                color: passwordFocusNode.hasFocus || isActivePassword == true
                    ? c3
                    : c6,
              ),
              controller: passwordController,
              focusNode: passwordFocusNode,
              textAlignVertical: TextAlignVertical.center,
              obscureText: showPasswword == false ? true : false,
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle:
                    passwordFocusNode.hasFocus || isActivePassword == true
                        ? c3TextStyle.copyWith()
                        : c6TextStyle.copyWith(),
              ),
            ),
          )),
          GestureDetector(
            onTap: () {
              setState(() {
                if (showPasswword == false) {
                  showPasswword = true;
                } else {
                  showPasswword = false;
                }
              });
            },
            child: Icon(
              showPasswword == true ? Icons.visibility : Icons.visibility_off,
              color: passwordFocusNode.hasFocus || isActivePassword == true
                  ? c3
                  : c6,
            ),
          )
        ]),
      );
    }

    Future<void> dialogBuilder(BuildContext context) {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: c3,
              title: Text('Perhatikan',
                  style: whiteTextStyle.copyWith(fontWeight: bold)),
              content:
                  usernameController.text == '' && passwordController.text == ''
                      ? Text(
                          'Silahkan isi username dan password terlebih dahulu',
                          style: whiteTextStyle.copyWith(),
                        )
                      : passwordController.text == ''
                          ? Text('Silahkan isi password terlebih dahulu',
                              style: whiteTextStyle.copyWith())
                          : usernameController.text == ''
                              ? Text('Silahkan isi username terlebih dahulu',
                                  style: whiteTextStyle.copyWith())
                              : usernameController.text != '' &&
                                      passwordController.text != '' &&
                                      succesLogin == true
                                  ? Text('Berhasil Login',
                                      style: whiteTextStyle.copyWith())
                                  : Text('Gagal Login',
                                      style: whiteTextStyle.copyWith()),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text('OKE',
                      style: whiteTextStyle.copyWith(fontWeight: bold)),
                  onPressed: () async {
                    if (succesLogin == true) {
                      await Provider.of<ProductProvider>(context, listen: false)
                          .getProducts();
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/main-page', (route) => false);
                    } else {
                      Navigator.pop(context);
                    }
                    setState(() {
                      succesLogin = false;
                    });
                  },
                ),
              ],
            );
          });
    }

    handleLogin() async {
      setState(() {
        isLoading = true;
      });
      if (usernameController.text == '' || passwordController.text == '') {
        dialogBuilder(context);
      } else if (usernameController.text != '' &&
          passwordController.text != '') {
        if (await authProvider.login(
            username: usernameController.text,
            password: passwordController.text)) {
          setState(() {
            succesLogin = true;
          });
          await Provider.of<ProductProvider>(context, listen: false)
                          .getProducts();
          dialogBuilder(context);
          Navigator.pushNamedAndRemoveUntil(
              context, '/main-page', (route) => false);
        } else {
          dialogBuilder(context);
        }
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget buttonSubmit() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        width: 200,
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: c1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            handleLogin();
          },
          child: Text(
            'Masuk',
            style: whiteTextStyle.copyWith(fontWeight: bold, fontSize: 16),
          ),
        ),
      );
    }

    Widget loadingSubmit() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        width: 200,
        height: 50,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: c1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {},
          child: const CircularProgressIndicator(
            color: c7,
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Stack(
        children: [
          ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/header-login.png',
                  fit: BoxFit.fill,
                ),
              ),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50, bottom: 56),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    usernameInput(),
                    passwordInput(),
                    isLoading == false ? buttonSubmit() : loadingSubmit()
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
