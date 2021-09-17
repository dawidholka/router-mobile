import 'package:flutter/cupertino.dart';
import 'package:router/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:router/models/waypoint_model.dart';

class UndeliveredList extends StatelessWidget {
  final CurrentRouteController controller = Get.find();

  UndeliveredList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
          itemCount: controller.undelivered.length,
          itemBuilder: (_, index) {
            WaypointModel item = controller.undelivered.elementAt(index);
            return Text(item.name);
          });
    });
  }
}
