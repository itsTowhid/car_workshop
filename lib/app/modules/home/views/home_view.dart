import 'package:car_workshop/app/modules/booking_calender/views/booking_calender_view.dart';
import 'package:car_workshop/app/modules/bookings/views/bookings_view.dart';
import 'package:car_workshop/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [BookingCalenderView(), BookingsView()];
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: Text(controller.getAppBarTitle())),
        body: _screens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: (idx) => controller.selectedIndex.value = idx,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calender'),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_to_photos_rounded),
              label: 'Create Booking',
            ),
          ],
        ),
      );
    });
  }
}
