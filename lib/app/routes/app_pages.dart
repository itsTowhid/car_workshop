import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:get/get.dart';

import '../modules/booking_calender/bindings/booking_calender_binding.dart';
import '../modules/booking_calender/views/booking_calender_view.dart';
import '../modules/bookings/bindings/bookings_binding.dart';
import '../modules/bookings/views/bookings_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static var INITIAL = FirebaseAuth.instance.currentUser == null
      ? Routes.FIRE_LOGIN
      : Routes.HOME;

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
    GetPage(
      name: _Paths.BOOKINGS,
      page: () => const BookingsView(),
      binding: BookingsBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_CALENDER,
      page: () => const BookingCalenderView(),
      binding: BookingCalenderBinding(),
    ),
  ];
}
