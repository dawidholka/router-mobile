import 'package:flutter/material.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/ui/ui.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Router',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.sanctumUser.value!.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('home.title'.tr),
            onTap: () {
              Get.offAll(() => HomeUI());
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: Text('map.title'.tr),
            onTap: () {
              Get.offAll(() => MapUI());
            },
          ),
          ListTile(
            leading: const Icon(Icons.pin_drop),
            title: Text('currentRoute.title'.tr),
            onTap: () {
              Get.offAll(CurrentRouteUI());
            }
          ),
          ListTile(
            leading: const Icon(Icons.navigation),
            title: Text('routes.title'.tr),
            onTap: () {
              Get.offAll(RoutesUI());
            },
          ),
          ListTile(
              leading: const Icon(Icons.settings),
              title: Text('settings.title'.tr),
              onTap: () {
                Get.to(SettingsUI());
              }),
          ListTile(
              leading: const Icon(Icons.info),
              title: Text('about.title'.tr),
              onTap: () {
                Get.to(SettingsUI());
              }),
        ],
      ),
    );
  }
}
