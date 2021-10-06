import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/models/models.dart';
import 'package:router/models/route.dart';
import 'package:router/models/route_list_model.dart';
import 'package:router/services/router_service.dart';
import 'package:router/ui/components/loading.dart';

class RoutesController extends GetxController {
  AuthController authController = Get.find();
  final store = GetStorage();

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

      Map<String, dynamic> routeData = await RouterService().getRoute(id: id);

      RouteModel route = RouteModel.fromMap(routeData);

      updateCurrentRoute(route);

      var waypointsList = routeData['waypoints']
          .map<WaypointModel>((data) => WaypointModel.fromMap(data))
          .toList();

      for (var element in waypointsList) {
        databaseHelper.saveWaypoint(element);
      }

      hideLoadingIndicator();
      Get.snackbar(
          'routes.routeDownloadedTitle'.tr, 'routes.routeDownloaded'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('common.errorOccurred'.tr, error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> updateCurrentRoute(RouteModel route) async {
    await store.write('current-route', route);
  }
}
