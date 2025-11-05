import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() async {
    final allBookings = await BookingService.getBookings();
    setState(() {
      bookings = allBookings;
    });
  }

  void _deleteBooking(int index) async {
    final allBookings = await BookingService.getBookings();
    allBookings.removeAt(index);
    final prefs = await BookingService.getBookings();
    await BookingService.addBooking(allBookings[index]); // optional save logic
    _loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page - All Bookings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet 😔'))
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final b = bookings[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading:
                        const Icon(Icons.build_circle, color: Colors.red),
                    title: Text('${b.service} (${b.userEmail})'),
                    subtitle: Text(
                        'Client: ${b.name}\nDevice: ${b.device}\nProblem: ${b.problem}\nPhone: ${b.phone}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // optional delete logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Delete feature coming soon!')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
