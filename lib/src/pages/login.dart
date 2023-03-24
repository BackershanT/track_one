import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';
import 'package:track_one/src/auth/auth_manager.dart';
import 'package:track_one/src/services/service_locator.dart';
import 'package:track_one/src/widgets/login_button.dart';
import 'package:track_one/src/widgets/users_text.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signUserIn()async{
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    ///try sign iin
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);

        await getIt<AuthManager>().getTemperature();
      ///pop the loading Circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {


      ///pop the loading Circle
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incorrect Email or password'),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(39, 26, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Track',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.location_on,
                        color: AppTheme.colors.red,
                      ),
                      Text(
                        'ne',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 72),
                  child: Row(
                    children: [
                      Text(
                        'Welcome Back !',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Row(
                    children: [
                      Text(
                        'Sign in to continue',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                UsersText(
                  obscureText: false,
                  hintText: 'Username',
                  controller: emailController,
                ),
                UsersText(
                  obscureText: true,
                  hintText: 'Password',
                  controller: passwordController,
                ),
                LoginButton(
                  text: 'Login Now',
                  onTap: signUserIn,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Forget Password ?',
                    style: TextStyle(fontSize: 15, color: AppTheme.colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 89.0, top: 143),
                  child: Row(
                    children: [
                      Text(
                        'Don\'t have an account ?',
                        style: TextStyle(
                            color: AppTheme.colors.darkgrey, fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Sign Up',
                          style:
                              TextStyle(color: AppTheme.colors.black, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
