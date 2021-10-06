class RouteModel {
  final int id;
  String? note;

  RouteModel({required this.id, required this.note});

  factory RouteModel.fromMap(Map data) {
    return RouteModel(id: data['id'], note: data['note']);
  }

  Map<String, dynamic> toJson() => {"id": id, "note": note};
}
