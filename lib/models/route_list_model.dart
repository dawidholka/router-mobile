class RouteListModel {
  final int id;
  final String ?note;
  final String date;

  RouteListModel({required this.id, required this.note, required this.date});

  factory RouteListModel.fromMap(Map data) {
    return RouteListModel(
        id: data['id'], note: data['note'], date: data['date']);
  }

  Map<String, dynamic> toJson() => {"id": id, "note": note, "date": date};
}
