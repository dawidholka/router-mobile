import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/controllers/routes_controller.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/ui/components/undelivered_list.dart';
import 'package:router/ui/ui.dart';
import 'package:get/get.dart';

class CurrentRouteUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CurrentRouteController>(
        init: CurrentRouteController(),
        builder: (controller) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('currentRoute.title'.tr),
                  bottom: TabBar(
                    tabs: [
                      Tab(text: 'currentRoute.undelivered'.tr),
                      Tab(text: 'currentRoute.delivered'.tr),
                    ],
                  ),
                ),
                drawer: AppDrawer(),
                body: _buildLayoutSection(context),
              ));
        });
  }

  Widget _buildLayoutSection(BuildContext context) {
    return TabBarView(
      children: [
        UndeliveredList(),
        DeliveredList(),
      ],
    );
  }
}
