import 'package:flutter/cupertino.dart';
import 'package:router/controllers/routes_controller.dart';
import 'package:get/get.dart';
import 'package:router/models/route_list_model.dart';
import 'package:router/ui/components/route_list_item.dart';

class RouteList extends StatelessWidget {
  final RoutesController controller = Get.find();

  RouteList();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.routes.length,
        itemBuilder: (_, index) {
          RouteListModel item = controller.routes.elementAt(index);
          return RouteListItem(item);
        },
      );
    });
  }
}
