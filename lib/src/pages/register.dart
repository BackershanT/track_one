import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';
import 'package:track_one/src/widgets/login_button.dart';
import 'package:track_one/src/widgets/users_text.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  ///textediting_controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  ///sign_Up_user_method
  void signUserUp() async {
    ///show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    ///try sign iin
    try {
      //check if password is confirmed
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);




      } else {
        //show error Mesage
        showErrorMessage("password didnt match!");
      }

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
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(resizeToAvoidBottomInset: false,
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
                              const Text(
                                'Track',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.location_on,
                                color: AppTheme.colors.red,
                              ),
                              const Text(
                                'ne',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0,top: 72),
                          child: Row(
                            children: [
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: AppTheme.colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        UsersText(
                          hintText: 'email',
                          obscureText: false,
                          controller: emailController,
                        ),
                        UsersText(
                          hintText: 'Password',
                          obscureText: true,
                          controller: passwordController,
                        ),UsersText(
                          hintText: 'Confirm Password',
                          obscureText: true,
                          controller: confirmpasswordController,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30,top: 50,),
                          child: Row(
                            children: [
                              Text('I agree with TERMS & CONDITIONS',style: TextStyle(color: AppTheme.colors.midgrey),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: LoginButton(text: 'Submit',onTap: signUserUp,

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(130,50, 0, 0),
                          child: GestureDetector( onTap: widget.onTap,
                            child: Row(
                              children: [
                                Text('Already have an Account?')
                              ],
                            ),
                          ),
                        )

                      ])
              ),
          )
        )
    );
  }
}
