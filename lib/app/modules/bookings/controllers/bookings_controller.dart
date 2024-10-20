import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form fields
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final regPlateController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();
  final customerEmailController = TextEditingController();
  final bookingTitleController = TextEditingController();
  final mechanicController = TextEditingController();

  final startDate = Rxn<DateTime>();
  final endDate = Rxn<DateTime>();

  Future<void> createBooking() async {
    try {
      await _firestore.collection('bookings').add({
        'car_make': makeController.text,
        'car_model': modelController.text,
        'car_year': yearController.text,
        'car_registration_plate': regPlateController.text,
        'customer_name': customerNameController.text,
        'customer_phone': customerPhoneController.text,
        'customer_email': customerEmailController.text,
        'booking_title': bookingTitleController.text,
        'start_datetime': startDate.value,
        'end_datetime': endDate.value,
        'assigned_mechanic': mechanicController.text,
        'created_at': Timestamp.now(),
      });
      Get.snackbar('Success', 'Booking created successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create booking: $e');
    }
  }
}
