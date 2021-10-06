import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/helpers/bitmap_descriptor_helper.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/models/models.dart';
import 'package:router/models/route.dart';
import 'package:router/models/route_list_model.dart';
import 'package:router/services/router_service.dart';
import 'package:router/ui/components/loading.dart';

class GoogleMapsController extends GetxController {
  AuthController authController = Get.find();

  static GoogleMapsController get to => Get.find();
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<WaypointModel> waypoints = RxList<WaypointModel>([]);
  RxList<WaypointModel> delivered = RxList<WaypointModel>([]);
  RxList<WaypointModel> undelivered = RxList<WaypointModel>([]);
  final Rxn<WaypointModel>? _selectedWaypoint = Rxn<WaypointModel>();
  Rxn<RouteModel>? currentRoute = Rxn<RouteModel>();
  final _picker = ImagePicker();
  final store = GetStorage();
  TextEditingController noteController = TextEditingController();
  RxSet<Marker> markers = <Marker>{}.obs;

  WaypointModel? get selectedWaypoint => _selectedWaypoint!.value;

  @override
  void onInit() async {
    await databaseHelper.openDB();
    loadWaypoints();
    loadCurrentRoute();
    super.onInit();
  }

  loadWaypoints() async {
    List waypointsData = await databaseHelper.getWaypoints();
    var waypointsList = waypointsData
        .map<WaypointModel>((data) => WaypointModel.fromMap(data))
        .toList();
    waypoints(waypointsList);
    var deliveredList = waypointsData
        .where((element) => element['status'] == 'delivered')
        .map<WaypointModel>((data) => WaypointModel.fromMap(data))
        .toList();
    var undeliveredList = waypointsData
        .where((element) =>
            element['status'] == 'undelivered' ||
            element['status'] == 'problem')
        .map<WaypointModel>((data) => WaypointModel.fromMap(data))
        .toList();

    delivered(deliveredList);
    undelivered(undeliveredList);
  }

  loadCurrentRoute() {
    RouteModel storeData = store.read('current-route');
    currentRoute!(storeData);
  }

  selectWaypoint(WaypointModel waypoint) async {
    _selectedWaypoint!.value = waypoint;
    noteController.text = waypoint.driverNote ?? '';
  }

  String get deliveryContent {
    Map<dynamic, dynamic> contentMap = {};

    for (var model in waypoints) {
      if (contentMap.containsKey(model.content) &&
          contentMap[model.content] != null) {
        contentMap[model.content] = contentMap[model.content] + 1;
      } else {
        contentMap[model.content] = 0;
      }
    }

    String contentString = '';

    contentMap.forEach((key, value) {
      contentString += key.toString() + ' - ' + value.toString() + '\n';
    });

    return contentString;
  }

  getImage() async {
    try {
      final XFile? file = await _picker.pickImage(source: ImageSource.camera);

      if (file == null) {
        return; // no photo selected
      }

      RouterService()
          .uploadImageToWaypoint(id: _selectedWaypoint!.value!.id, file: file);
      Get.snackbar(
          'currentRoute.imageUploadedTitle'.tr, 'currentRoute.imageUploaded',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } catch (exception) {
      Get.snackbar(
          'currentRoute.getImageErrorTitle'.tr, 'currentRoute.getImageError',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  changeWaypointStatus() async {
    WaypointModel waypoint = selectedWaypoint!;
    String newStatus =
        waypoint.status == 'delivered' ? 'undelivered' : 'delivered';
    try {
      await RouterService()
          .changeWaypointStatus(id: waypoint.id, status: newStatus);
      await databaseHelper.changeWaypointStatus(waypoint.id, newStatus);
      waypoint.status = newStatus;
      await loadWaypoints();
      selectWaypoint(waypoint);
      update();
      Get.snackbar(
          'currentRoute.statusUpdatedTitle'.tr, 'currentRoute.statusUpdated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } catch (exception) {
      print(exception);
      print('problem z zmiana statusu');
      Get.snackbar(
          'currentRoute.updateStatusErrorTitle'.tr, exception.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  changeWaypointProblem() async {
    WaypointModel waypoint = selectedWaypoint!;
    String newStatus = waypoint.status == 'problem' ? 'undelivered' : 'problem';
    try {
      await RouterService()
          .changeWaypointStatus(id: waypoint.id, status: newStatus);
      await databaseHelper.changeWaypointStatus(waypoint.id, newStatus);
      waypoint.status = newStatus;
      await loadWaypoints();
      selectWaypoint(waypoint);
      update();
      Get.snackbar(
          'currentRoute.statusUpdatedTitle'.tr, 'currentRoute.statusUpdated'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } catch (exception) {
      Get.snackbar(
          'currentRoute.updateStatusErrorTitle'.tr, exception.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  updateDriverNote() async {
    showLoadingIndicator();
    try {
      WaypointModel waypoint = selectedWaypoint!;
      String note = noteController.text;
      await RouterService().updateWaypointDriverNote(waypoint.id, note);
      await databaseHelper.updateWaypointDriverNote(waypoint.id, note);

      waypoint.driverNote = note;
      selectWaypoint(waypoint);
      update();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, error.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<Set<Marker>> getMarkers(BuildContext context) async {
    BitmapDescriptor undeliveredIcon = await BitmapDescriptorHelper().getSvgAsset(context, 'assets/pin-red.svg');

    Set<Marker> markers = {};
    for (WaypointModel element in waypoints) {
      markers.add(Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(element.lat, element.lng),
        icon: undeliveredIcon
      ));
    }

    return markers;
  }
}
