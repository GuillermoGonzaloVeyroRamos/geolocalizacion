import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocalizacion/presentation/screens/home/home_view/home_view.dart';
import 'package:geolocalizacion/presentation/screens/home/list_view/list_view.dart';
import 'package:geolocalizacion/presentation/widgets/shared/bottom_navbar.dart';
import 'package:geolocalizacion/presentation/screens/home/map_view/map_view.dart';

class HomeScreen extends StatelessWidget {

  final viewIndex; 

  HomeScreen({
    super.key,
    required this.viewIndex
  });

    final viewRoutes = [
      HomeView(),
      MapView(),
      PlacesView(),
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: viewIndex, children: viewRoutes,),
      bottomNavigationBar: ButtomNavbar(index: viewIndex),
    );
  }
}