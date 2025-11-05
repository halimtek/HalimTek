import 'package:flutter/material.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${service['title']} clicked')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
