import 'package:asthma/features/medication_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import '../main.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';

class MedicationForm extends StatefulWidget {
  const MedicationForm({super.key});

  @override
  State<MedicationForm> createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  int currentIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  void _showTimePicker() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2030, 12, 31),
      onChanged: (date) {
        // Called every time the user changes the selected date
      },
      onConfirm: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedTime != null) {
      final medication = Medication(
        name: _nameController.text,
        dosage: double.parse(_dosageController.text),
        time: _selectedTime!,
        date: _selectedDate!, // Add the selected date
      );
      scheduleNotification(medication);
      Navigator.pop(context, medication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the medication name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the medication dosage';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showTimePicker,
                child: Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : 'Selected Time: ${_selectedTime!.format(context)}',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showDatePicker,
                child: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : 'Selected Date: ${_selectedDate!.toString().substring(0, 10)}',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
