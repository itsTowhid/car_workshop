import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.FIRE_LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.FIRE_LOGIN,
      page: () => SignInScreen(
        providers: [EmailAuthProvider()],
        actions: [
          AuthStateChangeAction<SignedIn>(
              (ctx, state) => Get.offAndToNamed(Routes.HOME)),
        ],
      ),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
