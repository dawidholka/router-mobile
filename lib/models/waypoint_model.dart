class WaypointModel {
  final int id;
  final String name;
  final String address;
  final String city;
  final int stopNumber;
  final double lat;
  final double lng;

  WaypointModel(
      {required this.id,
      required this.name,
      required this.address,
      required this.city,
      required this.stopNumber,
      required this.lat,
      required this.lng});

  factory WaypointModel.fromMap(Map data) {
    return WaypointModel(
        id: data['id'],
        name: data['name'],
        address: data['address'],
        city: data['city'],
        stopNumber: data['stop_number'],
        lat: data['lat'],
        lng: data['lng']);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
