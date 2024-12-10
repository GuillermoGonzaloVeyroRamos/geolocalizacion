class Place {
  final String id;
  final String title;
  final String description;
  final double lat;
  final double lng;
  final bool isSent;
  final String category;
  final String imageUrl;
  String? address;

  Place(
      {required this.id,
      required this.title,
      required this.description,
      required this.lat,
      required this.lng,
      required this.isSent,
      required this.category,
      required this.imageUrl,
      this.address});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
        id: json["_id"] as String,
        title: json["title"] as String,
        description: json["description"] as String,
        lat: json["lat"] as double,
        lng: json["lng"] as double,
        isSent: json["isSent"] as bool, 
        category: json["category"] as String,
        imageUrl: json["imageUrl"] as String);
  }
}
