import 'package:flutter/material.dart';


class DetalleCardScreen extends StatelessWidget {
  final int id;

  DetalleCardScreen({super.key, required this.id});

  final List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Card 1',
      'description': 'Esta es la descripción de la Card 1. Es una tarjeta impresionante.',
    },
    {
      'id': 2,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Card 2',
      'description': 'Esta es la descripción de la Card 2. Otra tarjeta interesante.',
    },
    {
      'id': 3,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png0',
      'title': 'Card 3',
      'description': 'Esta es la descripción de la Card 3. Más detalles aquí.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final item = items.firstWhere((element) => element['id'] == id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de la Card'),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item['image'],
                    height: 400,
                    width: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  item['description'],
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}