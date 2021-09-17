import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/controllers/routes_controller.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/ui/components/route_list.dart';
import 'package:router/ui/ui.dart';
import 'package:get/get.dart';

class RoutesUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoutesController>(
      init: RoutesController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('routes.title'.tr),
          ),
          drawer: AppDrawer(),
          body: _buildLayoutSection(context),
        );
      }
      // (controller) => controller.sanctumUser.value == null
          // ? const Center(
          //     child: CircularProgressIndicator(),
          //   )
          // : Scaffold(
          //     appBar: AppBar(
          //       title: Text('routes.title'.tr),
          //     ),
          //     drawer: AppDrawer(),
          //     body: _buildLayoutSection(context),
          //   ),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return RouteList();
  }
}
