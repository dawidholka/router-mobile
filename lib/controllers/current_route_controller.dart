import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/models/models.dart';
import 'package:router/models/route_list_model.dart';
import 'package:router/services/router_service.dart';
import 'package:router/ui/components/loading.dart';

class CurrentRouteController extends GetxController {
  AuthController authController = Get.find();

  static CurrentRouteController get to => Get.find();
  DatabaseHelper databaseHelper = DatabaseHelper();

  RxList<WaypointModel> delivered = RxList<WaypointModel>([]);
  RxList<WaypointModel> undelivered = RxList<WaypointModel>([]);
  final Rxn<WaypointModel>? _selectedWaypoint = Rxn<WaypointModel>();
  final _picker = ImagePicker();
  TextEditingController noteController = TextEditingController();

  WaypointModel? get selectedWaypoint => _selectedWaypoint!.value;

  @override
  void onInit() async {
    print('oninit');
    await databaseHelper.openDB();
    loadWaypoints();
    super.onInit();
  }

  loadWaypoints() async {
    List waypointsData = await databaseHelper.getWaypoints();
    var waypointsList = waypointsData
        .map<WaypointModel>((data) => WaypointModel.fromMap(data))
        .toList();

    delivered(waypointsList);
  }

  selectWaypoint(WaypointModel waypoint) async {
    _selectedWaypoint!.value = waypoint;
  }

  getImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.camera);

    if(file == null){
      return;
    }

    RouterService().uploadImageToWaypoint(id: _selectedWaypoint!.value!.id, file: file);
    print(file);
  }
}
