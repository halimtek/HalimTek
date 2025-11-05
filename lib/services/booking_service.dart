import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingService {
  static const String bookingsKey = 'bookings';

  static Future<List<Booking>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final bookingsJson = prefs.getStringList(bookingsKey) ?? [];
    return bookingsJson.map((e) => Booking.fromMap(jsonDecode(e))).toList();
  }

  static Future<void> addBooking(Booking booking) async {
    final bookings = await getBookings();
    bookings.add(booking);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        bookingsKey, bookings.map((e) => jsonEncode(e.toMap())).toList());
  }
}
