import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_care/core/compnents.dart';
import 'package:health_care/core/geolocator_service.dart';

import '../../../../core/colors.dart';
import '../../domain/entities/place.dart';

class LocationsScreen extends StatefulWidget {
  final List<Place> places;
  final String type;
  final String title;

  const LocationsScreen(
      {Key? key, required this.places, required this.type, required this.title})
      : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  Position? currentLocation;

  getLocation() async {
    Position? location = await GeolocatorService.checkLocationServicesInDevice();
    if (location != null) {
      setState(() {
        currentLocation = location;
        initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          zoom: 20,
        );

        markers = [];
        for (Place place in widget.places) {
          markers.add(Marker(
            markerId: MarkerId(place.name),
            infoWindow: InfoWindow(
              title: place.name,
            ),
            position: LatLng(place.latitude, place.longitude),
          ));
        }
        markers.add(Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          markerId: const MarkerId('My Location'),
          infoWindow: const InfoWindow(
            title: 'My Location',
          ),
          position:
              LatLng(currentLocation!.latitude, currentLocation!.longitude),
        ));
      });
    }
  }

  GoogleMapController? googleMapController;
  CameraPosition? initialCameraPosition;

  List<Marker> markers = [];

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      target:
          LatLng(widget.places.first.latitude, widget.places.first.longitude),
      zoom: 20,
    );
    for (Place place in widget.places) {
      markers.add(Marker(
        markerId: MarkerId(place.name),
        infoWindow: InfoWindow(
          title: place.name,
        ),
        position: LatLng(place.latitude, place.longitude),
      ));
    }
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lotion,
      appBar:
          defaultAppBar(title: widget.title, context: context, withBack: true),
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        initialCameraPosition: initialCameraPosition!,
        onMapCreated: (controller) => googleMapController = controller,
        markers: markers.toSet(),
        onTap: (argument) {
          /* updateMarkers(LatLng(argument.latitude, argument.longitude));
          getUserLocation(
              latitude: argument.latitude,
              longitude: argument.longitude);*/
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getLocation(),
        backgroundColor: defaultColor,
        child: const Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
