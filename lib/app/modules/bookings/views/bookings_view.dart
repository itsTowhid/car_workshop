import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Car Details'),
            SizedBox(height: 10),
            _buildTextField(controller.makeController, 'Car Make'),
            _buildTextField(controller.modelController, 'Car Model'),
            _buildTextField(controller.yearController, 'Car Year',
                keyboardType: TextInputType.number),
            _buildTextField(
                controller.regPlateController, 'Registration Plate'),

            SizedBox(height: 20),
            SectionHeader(title: 'Customer Details'),
            SizedBox(height: 10),
            _buildTextField(controller.customerNameController, 'Customer Name'),
            _buildTextField(
                controller.customerPhoneController, 'Customer Phone Number',
                keyboardType: TextInputType.phone),
            _buildTextField(
                controller.customerEmailController, 'Customer Email',
                keyboardType: TextInputType.emailAddress),

            SizedBox(height: 20),
            SectionHeader(title: 'Booking Details'),
            SizedBox(height: 10),
            _buildTextField(controller.bookingTitleController, 'Booking Title'),

            Obx(() => _buildDateTimePicker(
                  context,
                  label: 'Start Date and Time',
                  date: controller.startDate.value,
                  onDateSelected: (DateTime? selected) {
                    if (selected != null && selected.isBefore(DateTime.now())) {
                      Get.snackbar('Error', 'You cannot select a past date.');
                    } else {
                      controller.startDate.value = selected;
                    }
                  },
                )),

            Obx(() => _buildDateTimePicker(
                  context,
                  label: 'End Date and Time',
                  date: controller.endDate.value,
                  onDateSelected: (DateTime? selected) {
                    if (selected != null &&
                        selected.isBefore(
                            controller.startDate.value ?? DateTime.now())) {
                      Get.snackbar(
                          'Error', 'End date cannot be before start date.');
                    } else {
                      controller.endDate.value = selected;
                    }
                  },
                )),

            SizedBox(height: 20),
            SectionHeader(title: 'Assign Mechanic'),
            SizedBox(height: 10),

            // Mechanics Dropdown
            Obx(() {
              if (controller.mechanicsList.isEmpty) {
                return CircularProgressIndicator(); // Loading state
              }
              return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Mechanic',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                items: controller.mechanicsList.map((mechanicName) {
                  return DropdownMenuItem(
                    value: mechanicName,
                    child: Text(mechanicName),
                  );
                }).toList(),
                onChanged: (value) {
                  controller.mechanicController.text = value ?? '';
                },
                value: controller.mechanicController.text.isEmpty
                    ? null
                    : controller.mechanicController.text,
              );
            }),

            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.startDate.value == null ||
                      controller.endDate.value == null) {
                    Get.snackbar('Error', 'Please select start and end dates.');
                  } else if (controller.mechanicController.text.isEmpty) {
                    Get.snackbar('Error', 'Please assign a mechanic.');
                  } else {
                    controller.createBooking();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: Text('Create Booking'),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper method to build a text field
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // Helper method to build a DateTime picker
  Widget _buildDateTimePicker(BuildContext context,
      {required String label,
      DateTime? date,
      required Function(DateTime?) onDateSelected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          '$label: ${date != null ? DateFormat('yyyy-MM-dd – kk:mm').format(date) : 'Select date and time'}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.calendar_today),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(), // Prevent past dates
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              DateTime selectedDateTime = DateTime(pickedDate.year,
                  pickedDate.month, pickedDate.day, time.hour, time.minute);
              onDateSelected(selectedDateTime);
            }
          }
        },
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
