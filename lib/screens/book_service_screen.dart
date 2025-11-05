import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookServiceScreen extends StatefulWidget {
  final String serviceName;
  final String userEmail;

  const BookServiceScreen({
    super.key,
    required this.serviceName,
    required this.userEmail,
  });

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _deviceController = TextEditingController();
  final _problemController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _deviceController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final booking = Booking(
        service: widget.serviceName,
        name: _nameController.text,
        phone: _phoneController.text,
        device: _deviceController.text,
        problem: _problemController.text,
        userEmail: widget.userEmail,
      );

      await BookingService.addBooking(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking sent for ${widget.serviceName}!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book ${widget.serviceName}'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                    labelText: 'Phone Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _deviceController,
                decoration: const InputDecoration(
                    labelText: 'Device Model', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your device model' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _problemController,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: 'Describe the Problem',
                    border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please describe the issue' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.send),
                label: const Text('Submit Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
