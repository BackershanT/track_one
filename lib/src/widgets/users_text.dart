import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';

class UsersText extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const UsersText({Key? key, this.controller, required this.hintText, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:30.0,top: 52),
      child: TextField(

        cursorColor: AppTheme.colors.midgrey,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(

          hintText: hintText,
          hintStyle: TextStyle(
              color: AppTheme.colors.midgrey
          ),
        ),




      ),
    );
  }
}
