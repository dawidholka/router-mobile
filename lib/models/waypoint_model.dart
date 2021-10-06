class WaypointModel {
  final int id;
  final int stopNumber;
  final String name;
  final String address;
  final String city;
  final double lat;
  final double lng;
  final String? phone;
  final String? intercom;
  final String? note;
  final String? deliveryTime;
  final String? content;
  final int? quantity;
  String status;
  String? driverNote;
  int photoUploaded = 0;

  WaypointModel({
    required this.id,
    required this.stopNumber,
    required this.name,
    required this.address,
    required this.city,
    required this.lat,
    required this.lng,
     this.phone,
     this.intercom,
     this.note,
     this.deliveryTime,
     this.content,
    required this.quantity,
    required this.status,
    this.driverNote,
    required this.photoUploaded,
  });

  factory WaypointModel.fromMap(Map data) {
    return WaypointModel(
      id: data['id'],
      stopNumber: data['stop_number'],
      name: data['name'],
      address: data['address'],
      city: data['city'],
      lat: data['lat'],
      lng: data['lng'],
      phone: data['phone'],
      intercom: data['intercom'],
      note: data['note'],
      deliveryTime: data['delivery_time'],
      content: data['content'],
      quantity: data['quantity'],
      status: data['status'],
      driverNote: data['driver_note'],
      photoUploaded: data['photo_uploaded'],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "stop_number": stopNumber,
    "name": name,
    "address": address,
    "city": city,
    "lat": lat,
    "lng": lng,
    "phone": phone,
    "intercom": intercom,
    "note": note,
    "delivery_time": deliveryTime,
    "content": content,
    "quantity": quantity,
    "status": status,
    "driver_note": driverNote,
    "photo_uploaded": photoUploaded,
  };
}
