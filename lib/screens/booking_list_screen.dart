import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingListScreen extends StatefulWidget {
  final String userEmail;

  const BookingListScreen({super.key, required this.userEmail});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<Booking> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() async {
    final allBookings = await BookingService.getBookings();
    setState(() {
      bookings =
          allBookings.where((b) => b.userEmail == widget.userEmail).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text('No bookings yet 😔', style: TextStyle(fontSize: 18)),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final b = bookings[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading:
                        const Icon(Icons.build_circle, color: Colors.blue),
                    title: Text(b.service),
                    subtitle: Text(
                        'Client: ${b.name}\nDevice: ${b.device}\nProblem: ${b.problem}'),
                    isThreeLine: true,
                    trailing: Text(
                      b.phone,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
