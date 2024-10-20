import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  // Car Details Controllers
  TextEditingController makeController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController regPlateController = TextEditingController();

  // Customer Details Controllers
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneController = TextEditingController();
  TextEditingController customerEmailController = TextEditingController();

  // Booking Details Controllers
  TextEditingController bookingTitleController = TextEditingController();
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  TextEditingController mechanicController = TextEditingController();

  // Mechanics List
  RxList<String> mechanicsList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMechanics();
  }

  // Method to fetch mechanics from Firestore
  void fetchMechanics() async {
    try {
      QuerySnapshot mechanicsSnapshot =
          await FirebaseFirestore.instance.collection('mechanics').get();
      List<String> fetchedMechanics =
          mechanicsSnapshot.docs.map((doc) => doc['name'].toString()).toList();
      mechanicsList.assignAll(fetchedMechanics); // Update the observable list
    } catch (e) {
      Get.snackbar('Error', 'Failed to load mechanics');
    }
  }

  // Method to create a booking
  void createBooking() {
    // Validation or booking creation logic goes here
    if (startDate.value == null || endDate.value == null) {
      Get.snackbar('Error', 'Please select valid start and end dates.');
      return;
    }

    if (mechanicController.text.isEmpty) {
      Get.snackbar('Error', 'Please assign a mechanic.');
      return;
    }

    // Proceed with booking creation and saving to database
    Get.snackbar('Success', 'Booking created successfully.');
  }
}
