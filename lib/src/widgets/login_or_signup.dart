import 'package:flutter/material.dart';
import 'package:track_one/src/pages/login.dart';
import 'package:track_one/src/pages/register.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({Key? key}) : super(key: key);

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool showLoginPages = true;
  void togglePages() {
    setState(() {
      showLoginPages = !showLoginPages;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPages){
      return LoginPage(onTap:togglePages);
    }else{
    return RegisterPage(onTap:togglePages);}
  }

}
