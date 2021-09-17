import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:router/models/waypoint_model.dart';
import 'package:router/ui/components/waypoint_note_editor.dart';

class WaypointUI extends StatelessWidget {
  final CurrentRouteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var waypoint = controller.selectedWaypoint;
    print(waypoint!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Punkt #${waypoint.stopNumber}'),
      ),
      body: Column(
        children: [
          _buildWaypointDetails(waypoint),
          _buildWaypointOptions(waypoint, context),
        ],
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
            Text(waypoint.name,
                style: const TextStyle(
                  fontSize: 24,
                )),
            const Text('Adres:',
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700, height: 2)),
            Text(waypoint.address, style: const TextStyle(fontSize: 16)),
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
              title: const Text('Dostarczone'),
              trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    print('switch');
                  }),
              onTap: () {
                controller.getImage();
              }),
        ),
        Card(
          child: ListTile(
              title: const Text('Problem z dostarczeniem'),
              trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    print('switch');
                  }),
              onTap: () {
                controller.getImage();
              }),
        ),
        Card(
          child: ListTile(
            title: const Text('Edytuj notatkę'),
            trailing: Icon(Icons.edit),
            onTap: () => {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return WaypointNoteEditor();
                }
              )
            },
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Nawigacja'),
            trailing: Icon(Icons.navigation),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Zadzwoń'),
            trailing: Icon(Icons.phone),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Wyślij SMS'),
            trailing: Icon(Icons.sms),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Zrób zdjęcie'),
            trailing: Icon(Icons.photo_camera),
            onTap: () {
              controller.getImage();
            },
          ),
        )
      ],
    );
  }
}
