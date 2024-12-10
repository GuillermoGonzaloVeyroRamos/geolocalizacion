import 'package:flutter/material.dart';
import 'package:geolocalizacion/domain/entities/Place.dart';
import 'package:geolocalizacion/domain/providers/place_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final imageUrlController = TextEditingController();
  final Set<Marker> _makers = {};

  void onTap(LatLng position) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          String selectedType = "Cultura";
          List<String> options = [
            "Cultura",
            "Tecnología",
            "Comida",
            "Eventos",
            "Deporte"
          ];
          return AlertDialog(
            title: const Text("Agregar lugar", style: TextStyle(fontWeight: FontWeight.bold),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Nombre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      labelText: "Descripción",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: InputDecoration(
                      labelText: "Imagen de referencia",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                    value: selectedType,
                    decoration: InputDecoration(
                        labelText: "Categoria",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
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
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                addMarker(position, nameController.text, descriptionController.text, selectedType, imageUrlController.text);
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
        });
  }

  Future addMarker(LatLng position, String title, String description,
      String type, String image) async {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    final place = Place(
        id: "",
        title: title,
        description: description,
        lat: position.latitude,
        lng: position.longitude,
        isSent: false,
        category: type,
        imageUrl: image);
    try {
      await placeProvider.addPlace(place);
      setState(() {
        _makers.add(Marker(
            markerId: MarkerId(place.id.toString()),
            position: LatLng(place.lat, place.lng),
            infoWindow:
                InfoWindow(title: place.title, snippet: place.description)));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMarkers();
    });
  }

  void loadMarkers() async {
    final placeProvider = Provider.of<PlaceProvider>(context, listen: false);
    await placeProvider.getPlace();
    setState(() {
      _makers.clear();
      for (var place in placeProvider.places) {
        _makers.add(Marker(
            markerId: MarkerId(place.id.toString()),
            position: LatLng(place.lat, place.lng),
            infoWindow:
                InfoWindow(title: place.title, snippet: place.description)));
      }
    });
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
        markers: _makers,
      ),
    );
  }
}
