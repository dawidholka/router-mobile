import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/ui/components/app_drawer.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/ui/ui.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => controller.sanctumUser.value == null
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
              const SizedBox(height: 10),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.album),
                    const ListTile(
                      leading: Icon(Icons.album),
                      title: Text('The Enchanted Nightingale'),
                      subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('BUY TICKETS'),
                          onPressed: () { /* ... */ },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('LISTEN'),
                          onPressed: () { /* ... */ },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormVerticalSpace(),
                  Text(
                      'home.nameLabel'.tr +
                          ': ' +
                          controller.sanctumUser.value!.name,
                      style: TextStyle(fontSize: 16)),
                  FormVerticalSpace(),
                  Text(
                      'home.adminUserLabel'.tr +
                          ': ' +
                          controller.admin.value.toString(),
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}