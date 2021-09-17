import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/models/models.dart';
import 'package:get/get.dart';
import 'package:router/ui/ui.dart';

class WaypointListItem extends StatelessWidget {
  final CurrentRouteController controller = Get.find();
  late final WaypointModel item;

  WaypointListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        '${item.stopNumber.toString()}. ${item.address}',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      onTap: () {
        controller.selectWaypoint(item);
        Get.to(() => WaypointUI());
      },
    ));
  }
}
