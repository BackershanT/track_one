import 'package:flutter/material.dart';
import 'package:track_one/src/app_colors/color.dart';

class WeatherCard extends StatelessWidget {
  final String degree;
  final String type;

  const WeatherCard({Key? key, required this.degree, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 91,
      width: 292,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppTheme.colors.weatherbox,
      ),child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24,top:11 ,bottom: 20),
          child: Icon(Icons.sunny,size: 60,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 42.0,top: 16),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(degree ,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(type,style: TextStyle(fontSize: 17),),
                ],
              ),
            ],
          ),
        )

      ],
    ),);
  }
}
