import 'package:flutter/material.dart';
import 'package:geolocalizacion/domain/datasources/place_datasource.dart';
import 'package:geolocalizacion/domain/entities/Place.dart';

class PlaceProvider extends ChangeNotifier {
  final PlaceDatasource _placeDatasource;

  PlaceProvider(this._placeDatasource);
  final List<Place> places= [];
  int cultureCount = 0;
  int technologyCount = 0;
  int foodCount = 0;
  int eventsCount = 0;
  int sportCount = 0;
  bool isLoading = false;

  Future<List<Place>> getPlace() async {
    isLoading = true;
    notifyListeners();
    try {
      final fetchedPlaces = await _placeDatasource.getPlaces();
      places.clear();
      places.addAll(fetchedPlaces);
      cultureCount = places
          .where(
            (element) => element.category == "Cultura",
          )
          .length;
      technologyCount = places
          .where(
            (element) => element.category == "Tecnología",
          )
          .length;
      foodCount = places
          .where(
            (element) => element.category == "Comida",
          )
          .length;
      eventsCount = places
          .where(
            (element) => element.category == "Eventos",
          )
          .length;
      sportCount = places
          .where(
            (element) => element.category == "Deporte",
          )
          .length;
      notifyListeners();
      return places;
    } catch (e) {
      print(e);
      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future addPlace(Place place) async {
    try {
      final newPlace = await _placeDatasource.addPlace(place);
      newPlace!.address = await _placeDatasource.getAddressFromLatLng(
          newPlace.lat, newPlace.lng);
      places.add(newPlace);
        cultureCount = places
          .where(
            (element) => element.category == "Cultura",
          )
          .length;
      technologyCount = places
          .where(
            (element) => element.category == "Tecnología",
          )
          .length;
      foodCount = places
          .where(
            (element) => element.category == "Comida",
          )
          .length;
      eventsCount = places
          .where(
            (element) => element.category == "Eventos",
          )
          .length;
      sportCount = places
          .where(
            (element) => element.category == "Deporte",
          )
          .length;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
