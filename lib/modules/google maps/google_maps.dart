import 'package:assignment_two/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF0A4D68),
      ),
      body: GoogleMap(

        onTap: (location){
          companyLocationOnMap=location;
          Navigator.pop(context);

        },
        initialCameraPosition: CameraPosition(
          target: LatLng(30.045916,31.224291),
          zoom: 15,
        ),
      ),


    );
  }
}
