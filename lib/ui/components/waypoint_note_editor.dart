import 'package:flutter/material.dart';
import 'package:router/controllers/current_route_controller.dart';
import 'package:router/helpers/validator.dart';
import 'package:router/ui/components/components.dart';
import 'package:get/get.dart';

class WaypointNoteEditor extends StatelessWidget {
  final CurrentRouteController controller = Get.find();

  WaypointNoteEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Edycja notatki'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              FormInputFieldWithIcon(
                controller: controller.noteController,
                iconPrefix: Icons.note,
                labelText: 'Notatka',
                validator: Validator().notEmpty,
                maxLines: 5,
                onChanged: (value) => null,
                onSaved: (value) => controller.noteController.text = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: () {}, child: Text('Zapisz'))
      ],
    );
  }
}
