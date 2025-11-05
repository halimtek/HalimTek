class Booking {
  final String service;
  final String name;
  final String phone;
  final String device;
  final String problem;
  final String userEmail;

  Booking({
    required this.service,
    required this.name,
    required this.phone,
    required this.device,
    required this.problem,
    required this.userEmail,
  });

  Map<String, dynamic> toMap() {
    return {
      'service': service,
      'name': name,
      'phone': phone,
      'device': device,
      'problem': problem,
      'userEmail': userEmail,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      service: map['service'],
      name: map['name'],
      phone: map['phone'],
      device: map['device'],
      problem: map['problem'],
      userEmail: map['userEmail'],
    );
  }
}
