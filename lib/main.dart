import 'package:car_workshop/app/modules/booking_calender/controllers/booking_calender_controller.dart';
import 'package:car_workshop/app/modules/bookings/controllers/bookings_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.lazyPut(() => BookingCalenderController());
  Get.lazyPut(() => BookingsController());

  runApp(
    GetMaterialApp(
      title: "SupCarWorks",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
