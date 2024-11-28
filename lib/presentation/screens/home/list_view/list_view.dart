import 'package:flutter/material.dart';
import 'package:geolocalizacion/presentation/screens/home/detail_view/detail_view.dart';


class PlacesView extends StatefulWidget {
  const PlacesView({super.key});

  @override
  State<PlacesView> createState() => _PlacesViewState();
}

class _PlacesViewState extends State<PlacesView> {
  final List<Map<String, dynamic>> items = [
    {
      'id': 1,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Estatua Arquitectura',
      'description': 'Esta es una breve descripción de la Card 1.',
      'label': 'Arte'
    },
    {
      'id': 2,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Card 2',
      'description': 'Esta es una breve descripción de la Card 2.',
      'label': 'Label 1'
    },
    {
      'id': 3,
      'image': 'https://traveler.marriott.com/es/wp-content/uploads/sites/2/2021/02/GI-884646886-Mexico-City-Angel-1920x1080.png',
      'title': 'Card 3',
      'description': 'Esta es una breve descripción de la Card 3.',
      'label': 'Label 1'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Cards'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Center(
            child: Card(
              elevation: 10,
              margin: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleCardScreen(id: item['id']),
                    ),
                  );
                },
                child: Container(
                  height: 400,
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          item['image']!,
                          height: 200,
                          width: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              item['description']!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),  // Ajusta el valor según tus necesidades
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),  // Añade espacio dentro del texto
                                color: Colors.blue,
                                child: Text(
                                  item['label']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
