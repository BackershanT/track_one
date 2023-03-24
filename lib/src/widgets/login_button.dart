import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';

class LoginButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const LoginButton({Key? key, this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 52.0),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
              height: 51,
              width: 282,
              decoration: BoxDecoration(
                  color: AppTheme.colors.red,
                  borderRadius: BorderRadius.circular(26)),
              child: Center(
                  child: Text(
                text,
                style: TextStyle(color: AppTheme.colors.white, fontSize: 16),
              )))),
    );
  }
}
