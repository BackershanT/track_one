import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_one/src/pages/home_page.dart';
import 'package:track_one/src/widgets/login_or_signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            return  const HomePage();
          }
          else{
            return  const LoginOrSignUp();
          }
        },
      ),
    );
  }
}
