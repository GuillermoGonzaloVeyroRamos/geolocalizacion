import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocalizacion/domain/entities/incident.dart';
import 'package:geolocalizacion/domain/providers/incident_provider.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final Set<Marker> _markers = {};

  void onTap(LatLng position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Agregar lugar",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                addMarker(position, nameController.text, descriptionController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void addMarker(LatLng position, String name, String description) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(DateTime.now().toIso8601String()),
        position: position,
        infoWindow: InfoWindow(title: name, snippet: description),
      ));
    });
    nameController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa de la Escuela"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.15252913173772, -101.71140780611424),
          zoom: 18,
        ),
        onLongPress: onTap,
        markers: _markers,
      ),
    );
  }
}
