import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:router/constants/constants.dart';
import 'package:router/controllers/controllers.dart';
import 'package:router/controllers/routes_controller.dart';
import 'package:router/ui/components/components.dart';
import 'package:router/helpers/helpers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.notification,
    Permission.storage,
  ].request();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await initServices();
  runApp(MyApp());
}

initServices() async{
  await Get.putAsync(() => LocationController().init());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale, // <- Current locale
          navigatorObservers: [
            // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
          ],
          debugShowCheckedModeBanner: false,
          //defaultTransition: Transition.fade,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: "/",
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
