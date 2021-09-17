import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:router/models/models.dart';
import 'package:router/services/router_service.dart';
import 'package:router/ui/auth/auth.dart';
import 'package:router/ui/ui.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/helpers/helpers.dart';

class AuthController extends GetxController {
  final storage = const FlutterSecureStorage();
  static AuthController to = Get.find();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rxn<UserModel> sanctumUser = Rxn<UserModel>();
  final RxBool admin = false.obs;

  @override
  void onReady() async {
    var name = await storage.read(key: 'name');
    var accessToken = await storage.read(key: 'accessToken');

    if (name != null && accessToken != null) {
      sanctumUser(UserModel(accessToken: accessToken, name: name));
      Get.offAll(HomeUI());
    }else{
      Get.offAll(SignInUI());
    }
    super.onReady();
  }

  @override
  void onClose() {
    loginController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_user) async {
    print('LOL');
    print(_user);
    // //get user data from firestore
    // if (_firebaseUser?.uid != null) {
    //   firestoreUser.bindStream(streamFirestoreUser());
    //   await isAdmin();
    // }
    //
    // if (_firebaseUser == null) {
    //   print('Send to signin');
    //   Get.offAll(SignInUI());
    // } else {
    //   Get.offAll(HomeUI());
    // }
  }

  // Firebase user one-time fetch
  // Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  // Stream<User?> get user => _auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  // Stream<UserModel> streamFirestoreUser() {
  //   print('streamFirestoreUser()');
  //
  //   return _db
  //       .doc('/users/${firebaseUser.value!.uid}')
  //       .snapshots()
  //       .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  // }

  //get the firestore user from the firestore collection
  // Future<UserModel> getFirestoreUser() {
  //   return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
  //           (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  // }

  signIn(BuildContext context) async {
    showLoadingIndicator();
    try {
      var userData = await RouterService().login(
          login: loginController.text.trim(),
          password: passwordController.text.trim());
      loginController.clear();
      passwordController.clear();

      await storage.write(key: 'name', value: userData.name);
      await storage.write(key: 'accessToken', value: userData.accessToken);
      sanctumUser(userData);

      Get.offAll(HomeUI());
      hideLoadingIndicator();
    } catch (error) {
      print(error.toString());
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  signOut() async {
    showLoadingIndicator();
    loginController.clear();
    passwordController.clear();

    await storage.deleteAll();

    Get.offAll(SignInUI());
    hideLoadingIndicator();
  }

// // Sign out
// Future<void> signOut() {
//   nameController.clear();
//   emailController.clear();
//   passwordController.clear();
//   return _auth.signOut();
// }
}
