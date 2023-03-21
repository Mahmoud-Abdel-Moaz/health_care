
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/core/compnents.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/place.dart';

class LocationsScreen extends StatelessWidget {
  final List<Place> places;
  final String type;
  final String title;
  const LocationsScreen({Key? key, required this.places, required this.type, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GoogleMapController? googleMapController;
     CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(places.first.latitude, places.first.longitude),
      zoom: 20,
    );
    List<Marker> markers = [];
    for(Place place in places){
      markers.add(Marker(
        markerId: MarkerId(place.name),
        infoWindow: InfoWindow(
          title: place.name,
        ),
        position: LatLng(place.latitude, place.longitude),
      ));
    }
    return Scaffold(
      backgroundColor: lotion,
      appBar: defaultAppBar(title: title, context: context,withBack: true),
      body:  GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller) => googleMapController = controller,
        markers: markers.toSet(),
        onTap: (argument) {
         /* updateMarkers(LatLng(argument.latitude, argument.longitude));
          getUserLocation(
              latitude: argument.latitude,
              longitude: argument.longitude);*/
        },
      ),

    );
  }
}


