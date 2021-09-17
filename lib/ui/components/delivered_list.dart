import 'package:flutter/cupertino.dart';
import 'package:router/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:router/models/waypoint_model.dart';
import 'package:router/ui/components/waypoint_list_item.dart';

class DeliveredList extends StatelessWidget {
  final CurrentRouteController controller = Get.find();

  DeliveredList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          itemCount: controller.delivered.length,
          itemBuilder: (_, index) {
            WaypointModel item = controller.delivered.elementAt(index);
            return WaypointListItem(item);
          });
    });
  }
}
