import 'package:flutter/material.dart';
import 'package:geolocalizacion/domain/providers/place_provider.dart';
import 'package:provider/provider.dart';


class DetalleCardScreen extends StatelessWidget {
  final String id;

   const DetalleCardScreen({Key? key, required this.id});
@override
  Widget build(BuildContext context) {
    // Obtener el lugar por ID desde el provider
    final incidentProvider = Provider.of<PlaceProvider>(context);
    final place = incidentProvider.places.firstWhere(
      (incident) => incident.id == id
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del lugar"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                place.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 30),
            Text(
              place.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                place.category,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Descripción:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              place.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}