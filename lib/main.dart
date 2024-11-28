import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocalizacion/config/app_routes.dart';
import 'package:geolocalizacion/domain/datasources/incident_datasource.dart';
import 'package:geolocalizacion/domain/providers/incident_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IncidentProvider(IncidentDatasource()))
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Material App',
        theme: ThemeData(
          fontFamily: "Poppins"
        ),
      ),
    );
  }
}