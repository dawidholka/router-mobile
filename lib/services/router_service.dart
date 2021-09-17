import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:router/controllers/auth_controller.dart';
import 'package:router/helpers/helpers.dart';
import 'package:router/models/models.dart';

class RouterService extends GetConnect {
  AuthController authController = Get.find();
  static const _baseURL = 'http://192.168.178.49/api';

  Future<UserModel> login(
      {required String login, required String password}) async {
    try {
      // var deviceName = await DeviceInfo.getId();
      var deviceName = 'test';
      var body = {
        'login': login,
        'password': password,
        'device_name': deviceName
      };

      final response = await post(
          'http://192.168.178.49/api/create-token', body,
          headers: {'accept': 'application/json'});

      if (response.status.hasError) {
        return Future.error({response.statusText});
      } else {
        var user = UserModel.fromMap(response.body);
        return user;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<List<dynamic>> getRoutes() async {
    try {
      var headers = {
        'accept': 'application/json',
        'Authorization':
            'Bearer ' + authController.sanctumUser.value!.accessToken
      };
      final response = await get(_baseURL + '/routes', headers: headers);
      if (response.status.hasError) {
        return Future.error({response.statusText});
      } else {
        return response.body;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<List<dynamic>> getRoute({required int id}) async {
    try {
      var headers = {
        'accept': 'application/json',
        'Authorization':
            'Bearer ' + authController.sanctumUser.value!.accessToken
      };
      final response =
          await get(_baseURL + '/routes/' + id.toString(), headers: headers);
      if (response.status.hasError) {
        return Future.error({response.statusText});
      } else {
        return response.body['waypoints'];
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future uploadImageToWaypoint({required int id, required XFile file}) async {
    try {
      var headers = {
        'accept': 'application/json',
        'Authorization':
            'Bearer ' + authController.sanctumUser.value!.accessToken
      };
      List<int> imageData = await file.readAsBytes();
      String filename = 'photo-waypoint-' + id.toString() + '.jpeg';
      final image = MultipartFile(imageData, filename: filename);
      FormData data = FormData({'image': image});


      final response = await post(
          '$_baseURL/waypoints/${id.toString()}/upload-image',
          data,
          headers: headers);

      print(response.statusCode);

      if (response.status.hasError) {
        return Future.error({response.statusText});
      } else {
        return true;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
