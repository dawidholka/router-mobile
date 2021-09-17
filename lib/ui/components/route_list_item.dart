import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:router/controllers/routes_controller.dart';
import 'package:router/models/route_list_model.dart';

class RouteListItem extends StatelessWidget {
  final RoutesController controller = Get.find();
  late final RouteListModel item;

  RouteListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Trasa #' + item.id.toString(),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(height: 5),
          Text(
            item.date,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text('Notatka: ' + (item.note ?? 'Brak'),
              style: TextStyle(
                fontSize: 18,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('POBIERZ'),
                onPressed: () {
                  controller.downloadRoute(id: item.id);
                },
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
