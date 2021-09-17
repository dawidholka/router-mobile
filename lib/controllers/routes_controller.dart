import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/models/models.dart';
import 'package:router/models/route_list_model.dart';
import 'package:router/services/router_service.dart';
import 'package:router/ui/components/loading.dart';

class RoutesController extends GetxController {
  AuthController authController = Get.find();

  static RoutesController get to => Get.find();
  DatabaseHelper databaseHelper = DatabaseHelper();

  RxList<RouteListModel> routes = RxList<RouteListModel>([]);

  RoutesController() {
    loadRoutes();
  }

  @override
  void onInit() async {
    await databaseHelper.openDB();
    super.onInit();
  }

  loadRoutes() async {
    try {
      var routesData = await RouterService().getRoutes();
      routes.addAll(routesData
          .map<RouteListModel>((data) => RouteListModel.fromMap(data))
          .toList());
    } catch (error) {
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  downloadRoute({required int id}) async {
    showLoadingIndicator();
    try {
      databaseHelper.deleteAllWaypoints();

      var routeData = await RouterService().getRoute(id: id);
      var waypointsList = routeData
          .map<WaypointModel>((data) => WaypointModel.fromMap(data))
          .toList();

      waypointsList.forEach((element) {
        databaseHelper.saveWaypoint(element);
      });

      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }
}
