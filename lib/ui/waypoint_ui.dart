import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:router/models/waypoint_model.dart';
import 'package:router/ui/components/waypoint_note_editor.dart';

class WaypointUI extends StatelessWidget {
  final CurrentRouteController c = Get.find();

  WaypointUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WaypointModel? waypoint = c.selectedWaypoint;
    return Scaffold(
      appBar: AppBar(
        title: Text('common.waypoint'.tr + ' #${waypoint!.stopNumber}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildWaypointDetails(waypoint),
            _buildWaypointOptions(waypoint, context),
          ],
        ),
      ),
    );
  }

  Widget _buildWaypointDetails(WaypointModel waypoint) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              waypoint.name,
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'common.address'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.address,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.intercom'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.intercom ?? '-',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.phone'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.phone ?? '-',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.content'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.content ?? '-',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.quantity'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.quantity.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.note'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.note ?? '-',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'common.driverNote'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            GetBuilder<CurrentRouteController>(builder: (c) {
              return Text(
                waypoint.driverNote ?? '-',
                style: const TextStyle(fontSize: 16),
              );
            }),
            Text(
              'waypoint.photoUploaded'.tr + ':',
              style: _listBoldTextStyle(),
            ),
            Text(
              waypoint.photoUploaded == 1 ? 'common.yes'.tr : 'common.no'.tr,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWaypointOptions(WaypointModel waypoint, BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
              title: Text('currentRoute.delivered'.tr),
              trailing: GetBuilder<CurrentRouteController>(builder: (c) {
                return Switch(
                    value: c.selectedWaypoint!.status == 'delivered',
                    onChanged: (value) async {
                      await c.changeWaypointStatus();
                      c.update();
                    });
              }),
              onTap: () {
                c.getImage();
              }),
        ),
        Card(
          child: ListTile(
              title: Text('waypoint.deliveryProblem'.tr),
              trailing: GetBuilder<CurrentRouteController>(builder: (c) {
                return Switch(
                    value: c.selectedWaypoint!.status == 'problem',
                    onChanged: (value) async {
                      await c.changeWaypointProblem();
                      c.update();
                    });
              }),
              onTap: () {
                c.getImage();
              }),
        ),
        Card(
          child: ListTile(
            title: Text('waypoint.editDriverNote'.tr),
            trailing: const Icon(Icons.edit),
            onTap: () => {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return WaypointNoteEditor();
                  })
            },
          ),
        ),
        Card(
          child: ListTile(
            title: Text('waypoint.navigate'.tr),
            trailing: const Icon(Icons.navigation),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('waypoint.call'.tr),
            trailing: const Icon(Icons.phone),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('waypoint.sendSMS'.tr),
            trailing: const Icon(Icons.sms),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('waypoint.takePhoto'.tr),
            trailing: const Icon(Icons.photo_camera),
            onTap: () {
              c.getImage();
            },
          ),
        )
      ],
    );
  }

  TextStyle _listBoldTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      height: 2,
    );
  }
}
