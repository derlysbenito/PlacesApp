import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technical_test/data/models/users_response.dart';

class SearchUserMap extends StatefulWidget {
  final UsersResponse model;

  const SearchUserMap({super.key, required this.model});

  @override
  State<SearchUserMap> createState() => _SearchUserMapState();
}

class _SearchUserMapState extends State<SearchUserMap> {
  late CameraPosition _initialPosition;

  @override
  void initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(widget.model.latitude, widget.model.longitude),
      zoom: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ubicación del Usuario")),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {},
        initialCameraPosition: _initialPosition,
        markers: {userMarker()},
      ),
    );
  }

  Marker userMarker() {
    return Marker(
      markerId: MarkerId(widget.model.id.toString()),
      position: LatLng(widget.model.latitude, widget.model.longitude),
    );
  }
}
