import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/ui/components/app_drawer.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/ui/ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentRouteController>(
      init: CurrentRouteController(),
      builder: (controller) =>
      false
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Scaffold(
        appBar: AppBar(
          title: Text('home.title'.tr),
        ),
        drawer: AppDrawer(),
        body: Center(
          child: Column(
            children: <Widget>[
              _currentRouteCard(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currentRouteCard(CurrentRouteController controller) {
    return Obx(() {
      return controller.currentRoute?.value != null
          ? Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.navigation, size: 50),
              title: Text('Aktualna trasa #' +
                  controller.currentRoute!.value!.id.toString(),
              style: const TextStyle(height: 1.85),),
              subtitle: Text('Dostarczone: ' +
                  controller.delivered.length.toString() +
                  '\n' +
                  'Niedostarczone: ' +
                  controller.undelivered.length.toString() +
                  '\nNotatka: \n' +
                  (controller.currentRoute!.value!.note ?? '-') +
                  '\nZawartość: \n' +
                  controller.deliveryContent
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('PRZEJDŹ DO TRASY'),
                  onPressed: () async {
                    Get.off(() => CurrentRouteUI());
                  },
                ),
              ],
            ),
          ],
        ),
      )
          : Container();
    });
  }
}
