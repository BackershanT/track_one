import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_one/src/widgets/weather_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogleplex =
      const CameraPosition(target: LatLng(9.9874879, 76.2843212), zoom: 15);

  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(9.9874879, 76.2843212),
        infoWindow: InfoWindow(title: 'My Location'))
  ];
  // loadData() {
  //   getUserCurrentLocation().then((value) async {
  //     print('my current location');
  //     print(value.latitude.toString() + "-" + value.longitude.toString());
  //     _markers.add(Marker(
  //         markerId: const MarkerId('2'),
  //         position: LatLng(value.latitude, value.longitude),
  //         infoWindow: const InfoWindow(title: 'My Current Location')));
  //     CameraPosition cameraPosition = CameraPosition(
  //       zoom: 14,
  //       target: LatLng(value.latitude, value.longitude),
  //     );
  //     final GoogleMapController controller = await _controller.future;
  //     controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //     setState(() {});
  //   });
  // }

  // Future<Position> getUserCurrentLocation() async {
  //   await Geolocator.requestPermission()
  //       .then((value) {})
  //       .onError((error, stackTrace) {
  //     print("error" + error.toString());
  //   });
  //   return await Geolocator.getCurrentPosition();
  // }

  @override
  void initState() {
    super.initState();
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: [
        Container(
          child: GoogleMap(
            myLocationEnabled: true,
            initialCameraPosition: _kGoogleplex,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
        Positioned(
            top: 20,
            left: 110,
            child: WeatherCard(degree: "degree\u2103", type: "type"))
      ]),

    ));
  }
}
