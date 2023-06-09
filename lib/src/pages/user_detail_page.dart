import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_one/src/app_colors/color.dart';
import 'package:track_one/src/services/service_locator.dart';
import 'package:track_one/src/widgets/weather_card.dart';

class UserDetailPage extends StatefulWidget {
  final name;
  final lati;
  final long;

  const UserDetailPage({
    Key? key,
    required this.name,
    required this.lati,
    required this.long,
  }) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  int? degree = getIt<SharedPreferences>().getInt("degree");
  String? description = getIt<SharedPreferences>().getString("description");
  late int latit = (widget.lati).toInt();
  late int longi = (widget.long).toInt();

  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGoogleplex =
       const CameraPosition(target: LatLng(9.9874879, 76.2843212), zoom: 15);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  List<LatLng> latlng = [
    const LatLng(9.9874879, 76.2843212),
    const LatLng(10.9874879, 76.2843212),
    //   // LatLng()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(title: widget.name, snippet: '**'),
          icon: BitmapDescriptor.defaultMarker));
      setState(() {});
      _polyline.add(
        Polyline(
            polylineId: const PolylineId('1'),
            points: latlng,
            visible: true,
            jointType: JointType.bevel,
            geodesic: true,
            endCap: Cap.buttCap,
            zIndex: 1,
            startCap: Cap.buttCap,
            color: AppTheme.colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppTheme.colors.black,
            )),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 17, color: AppTheme.colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: AppTheme.colors.black,
            ),
          )
        ],
      ),
      body: Stack(children: [
        Container(
          child: GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _kGoogleplex,
            mapType: MapType.normal,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            polylines: _polyline,
          ),
        ),
        Positioned(
            top: 20,
            left: 110,
            child: WeatherCard(
              degree: degree.toString(),
              type: description.toString(),
            ))
      ]),
    ));
  }
}
