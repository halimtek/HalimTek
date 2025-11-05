import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AnimatedRegisterScreen extends StatefulWidget {
  const AnimatedRegisterScreen({super.key});

  @override
  State<AnimatedRegisterScreen> createState() => _AnimatedRegisterScreenState();
}

class _AnimatedRegisterScreenState extends State<AnimatedRegisterScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat(reverse: true);

    _color1 = ColorTween(begin: Colors.blueAccent, end: Colors.deepPurple)
        .animate(_controller);
    _color2 =
        ColorTween(begin: Colors.lightBlue, end: Colors.purpleAccent)
            .animate(_controller);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final user = await AuthService.login(
          _emailController.text, _passwordController.text);
      if (user != null) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  HomeScreen(currentUserEmail: user.email, isAdmin: user.isAdmin),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_color1.value!, _color2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.scale(
                        scale: value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Icon(Icons.build_circle,
                              size: 80, color: Colors.blue),
                          const SizedBox(height: 16),
                          const Text(
                            'Register to HalimTek',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter name' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter phone number' : null,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter email' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter password' : null,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              const AnimatedLoginScreen(),
                                          transitionsBuilder: (_, a, __, c) =>
                                              SlideTransition(
                                                position: Tween<Offset>(
                                                        begin: const Offset(
                                                            1, 0),
                                                        end: Offset.zero)
                                                    .animate(a),
                                                child: c,
                                              )));
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
