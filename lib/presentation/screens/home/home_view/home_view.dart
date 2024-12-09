import 'package:flutter/material.dart';
import 'package:geolocalizacion/domain/providers/incident_provider.dart';
import 'package:geolocalizacion/presentation/widgets/shared/info_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, dynamic>> places = [
    {
      'id': 1,
      'image':
          'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Biblioteca',
      'label': 'Cultura',
      'description': 'Espacio ideal para estudiar y leer libros.'
    },
    {
      'id': 2,
      'image':
          'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Cafetería',
      'label': 'Comida',
      'description': 'Deliciosos platillos para disfrutar.'
    },
    {
      'id': 3,
      'image':
          'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Laboratorio',
      'label': 'Tecnología',
      'description': 'Innovación y tecnología avanzada.'
    },
    {
      'id': 4,
      'image':
          'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Auditorio',
      'label': 'Eventos',
      'description': 'Eventos y conferencias importantes.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares Importantes'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Doble fila
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 1.5, // Relación tamaño 
        ),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                print('Lugar ${place['id']} seleccionado');
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.network(
                      place['image']!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported,
                            size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place['title']!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            place['label']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          place['description']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
