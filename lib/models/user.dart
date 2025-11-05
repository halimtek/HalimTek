class User {
  final String email;
  final String password;
  final bool isAdmin;

  User({required this.email, required this.password, this.isAdmin = false});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      password: map['password'],
      isAdmin: map['isAdmin'] ?? false,
    );
  }
}
