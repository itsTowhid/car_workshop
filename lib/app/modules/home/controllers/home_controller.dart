import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedIndex = 0.obs;

  String getAppBarTitle() {
    switch (selectedIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'Bookings';
      default:
        return '';
    }
  }
}
