import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/models/waypoint_model.dart';
import 'package:router/ui/waypoint_ui.dart';
import 'components/app_drawer.dart';
import 'package:get/get.dart';

class MapUI extends StatelessWidget {
  static LocationController to = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('routes.title'.tr),
      ),
      drawer: AppDrawer(),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return GetBuilder<CurrentRouteController>(
        init: CurrentRouteController(),
        builder: (controller)  {
          return Obx(() =>
            GoogleMap(
              markers: getMarkers(controller),
              mapType: MapType.hybrid,
              trafficEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: to.getCurrentLocation(),
            )

          );
        }
    );
  }

  Set<Marker> getMarkers(controller) {
    Set<Marker> markers = {};


    for (WaypointModel element in controller.waypoints) {
      var waypointHue = 0.0;
      switch(element.status){
        case 'delivered':
          waypointHue = BitmapDescriptor.hueGreen;
          break;
        case 'undelivered':
          waypointHue = BitmapDescriptor.hueYellow;
          break;
        case 'problem':
          waypointHue = BitmapDescriptor.hueRed;
      }
      markers.add(Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(element.lat, element.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(waypointHue),
          onTap: () {
            controller.selectWaypoint(element);
            Get.to(() => WaypointUI());
          }
      ));
    }

    return markers;
  }
}
