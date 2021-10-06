import 'package:get/get.dart';
import 'package:background_location/background_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:router/services/router_service.dart';

class LocationController extends GetxService {
  static LocationController to = Get.find();

  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  Future<LocationController> init() async {
    await BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: '@mipmap/ic_launcher',
    );
    await BackgroundLocation.stopLocationService();
    await BackgroundLocation.setAndroidConfiguration(10000);
    await BackgroundLocation.startLocationService(distanceFilter: 20);
    BackgroundLocation.getLocationUpdates((location) {
      RouterService().sendLocation(location);
      lat(location.latitude);
      lng(location.longitude);
    });
    return this;
  }

  CameraPosition getCurrentLocation() {
    return CameraPosition(
      target: LatLng(lat.value, lng.value),
      zoom: 14.4746,
    );
  }
}
