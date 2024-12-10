import 'package:dio/dio.dart';
import 'package:geolocalizacion/config/constants.dart';
import 'package:geolocalizacion/domain/entities/Place.dart';

class PlaceDatasource {

  final placeClient = Dio(BaseOptions(
    baseUrl: Constants.baseApiUrl
  ));

Future<List<Place>> getPlaces() async {
  final response = await placeClient.get("/poi");
  final placesData = response.data as List;
  print(placesData);
  final placeList = placesData.map((item) => Place.fromJson(item)).toList();
  return placeList;
}

Future<String?> getAddressFromLatLng(double lat, double lng) async {
  Dio client = Dio();
  try {
    final response = await client.get(Constants.mapsGeoCodeUrl, queryParameters: {
      "latlng": "$lat,$lng",
      "key": Constants.mapsApiKey
    });
    if(response.statusCode == 200){
      final data = response.data;
      if(data["status"] == "OK"){
        final results = data["results"];
        final address = results[0]["formatted_address"];
        return address;
      }
    }
    return "";
  }
  catch(e){
    print(e);
    return "";
  }
    
  }

  Future<Place?> addPlace(Place place) async {
    try {
      final response = await placeClient.post("/poi", data: {
        "title": place.title,
        "description": place.description,
        "lat": place.lat,
        "lng": place.lng,
        "isSent": place.isSent,
        "category": place.category,
        "imageUrl": place.imageUrl
      });
      return Place.fromJson(response.data);
      
    } catch (e) {
      print(e);
      return null;      
    }

  }


}