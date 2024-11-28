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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final Set<Marker> _makers = {};

  void onTap(LatLng position) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String selectedType = "Robos";
          List<String> options = ["Robos", "Tráfico"];
          return AlertDialog(
            title: Text("Agregar incidente"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      labelText: "Titulo",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: "Descripción",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                ),
                const SizedBox(
                  height: 30,
                ),
                DropdownButtonFormField(
                    value: selectedType,
                    decoration: InputDecoration(
                        labelText: "Tipo de incidente",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    items: options.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      if (value != null) {
                        selectedType = value;
                      }
                    }),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    addMarker(position, titleController.text,
                        descriptionController.text, selectedType);
                  },
                  child: Text("Aceptar"))
            ],
          );
        });
  }

  Future addMarker(
      LatLng position, String title, String description, String type) async {
    final incidentProvider =
        Provider.of<IncidentProvider>(context, listen: false);
    final incident = Incident(
        id: "",
        title: title,
        description: description,
        lat: position.latitude,
        lng: position.longitude,
        isEmailSent: false,
        type: type);
    try {
      await incidentProvider.addIncident(incident);
      setState(() {
        _makers.add(Marker(
            markerId: MarkerId(incident.id),
            position: LatLng(incident.lat, incident.lng),
            infoWindow: InfoWindow(
                title: incident.title, snippet: incident.description)));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*   final datasource = IncidentDatasource();
    datasource.getIncidents(); */
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMarkers();
    });
  }

  void loadMarkers() async {
    final incidentProvider =
        Provider.of<IncidentProvider>(context, listen: false);
    await incidentProvider.getIncidents();
    setState(() {
      _makers.clear();
      for (var incident in incidentProvider.incidents) {
        _makers.add(Marker(
            markerId: MarkerId(incident.id),
            position: LatLng(incident.lat, incident.lng),
            infoWindow: InfoWindow(
                title: incident.title, snippet: incident.description)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) {
        mapController = controller;
      },
      initialCameraPosition: const CameraPosition(
          target: LatLng(21.15252913173772, -101.71140780611424), zoom: 18),
      onLongPress: onTap,
      markers: _makers,
    );
  }
}
