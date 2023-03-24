import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';

class UserListCard extends StatelessWidget {
  final String name;
  final Function()? onTap;
  final String id;
  const UserListCard({Key? key, required this.name, required this.id, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0,),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(name,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color: AppTheme.colors.black),),
          subtitle: Text(id,style: TextStyle(fontSize: 17,fontWeight: FontWeight.w200,color: AppTheme.colors.black),),

        ),
      ),
    )
    ;
  }
}
