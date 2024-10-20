import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/bookings_controller.dart';

class BookingsView extends GetView<BookingsController> {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Car details
              TextFormField(
                controller: controller.makeController,
                decoration: InputDecoration(labelText: 'Car Make'),
              ),
              TextFormField(
                controller: controller.modelController,
                decoration: InputDecoration(labelText: 'Car Model'),
              ),
              TextFormField(
                controller: controller.yearController,
                decoration: InputDecoration(labelText: 'Car Year'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: controller.regPlateController,
                decoration: InputDecoration(labelText: 'Registration Plate'),
              ),

              // Customer details
              TextFormField(
                controller: controller.customerNameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
              ),
              TextFormField(
                controller: controller.customerPhoneController,
                decoration: InputDecoration(labelText: 'Customer Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: controller.customerEmailController,
                decoration: InputDecoration(labelText: 'Customer Email'),
                keyboardType: TextInputType.emailAddress,
              ),

              // Booking title
              TextFormField(
                controller: controller.bookingTitleController,
                decoration: InputDecoration(labelText: 'Booking Title'),
              ),

              // Start DateTime picker
              Obx(() => ListTile(
                    title: Text(
                        'Start Date: ${controller.startDate.value != null ? DateFormat('yyyy-MM-dd – kk:mm').format(controller.startDate.value!) : 'Select start date'}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          controller.startDate.value = DateTime(picked.year,
                              picked.month, picked.day, time.hour, time.minute);
                        }
                      }
                    },
                  )),

              // End DateTime picker
              Obx(() => ListTile(
                    title: Text(
                        'End Date: ${controller.endDate.value != null ? DateFormat('yyyy-MM-dd – kk:mm').format(controller.endDate.value!) : 'Select end date'}'),
                    trailing: Icon(Icons.calendar_today),
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null) {
                          controller.endDate.value = DateTime(picked.year,
                              picked.month, picked.day, time.hour, time.minute);
                        }
                      }
                    },
                  )),

              // Assign mechanic
              TextFormField(
                controller: controller.mechanicController,
                decoration: InputDecoration(labelText: 'Assign Mechanic'),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.createBooking();
                },
                child: Text('Create Booking'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
