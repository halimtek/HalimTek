import 'package:flutter/material.dart';
import '../widgets/service_card.dart';
import 'book_service_screen.dart';
import 'booking_list_screen.dart';
import '../services/auth_service.dart';
import 'admin_page.dart';

class HomeScreen extends StatelessWidget {
  final String currentUserEmail;
  final bool isAdmin;

  const HomeScreen({super.key, required this.currentUserEmail, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'title': 'FRP Removal', 'icon': Icons.lock_open},
      {'title': 'Phone Unlock', 'icon': Icons.phone_android},
      {'title': 'IMEI Repair', 'icon': Icons.settings},
      {'title': 'Flashing', 'icon': Icons.memory},
      {'title': 'Software Update', 'icon': Icons.system_update},
      {'title': 'Battery Replacement', 'icon': Icons.battery_charging_full},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('HalimTek'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          if (isAdmin)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()));
                },
                icon: const Icon(Icons.admin_panel_settings)),
          IconButton(
            onPressed: () async {
              await AuthService.logout();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return ServiceCard(
              title: service['title'] as String,
              icon: service['icon'] as IconData,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookServiceScreen(
                        serviceName: service['title'] as String,
                        userEmail: currentUserEmail),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BookingListScreen(userEmail: currentUserEmail)),
          );
        },
        label: const Text('My Bookings'),
        icon: const Icon(Icons.list_alt),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }
}
