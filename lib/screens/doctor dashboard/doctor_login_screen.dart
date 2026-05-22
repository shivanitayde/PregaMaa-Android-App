import 'package:flutter/material.dart';
import 'doctor_dashboard.dart';

class DoctorLoginScreen extends StatefulWidget {
  const DoctorLoginScreen({super.key});

  @override
  State<DoctorLoginScreen> createState() => _DoctorLoginScreenState();
}

class _DoctorLoginScreenState extends State<DoctorLoginScreen>
    with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final hospitalController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = false;

  late AnimationController controller;
  late Animation<double> logoAnimation;
  late Animation<double> formAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    formAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submit() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DoctorDashboard()),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF9AA2), Color(0xFFFFB7B2)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: FadeTransition(
              opacity: formAnimation,

              child: Column(
                children: [
                  /// Animated Logo
                  ScaleTransition(
                    scale: logoAnimation,

                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,

                      child: Icon(
                        Icons.local_hospital,
                        size: 40,
                        color: Colors.pink,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    isLogin ? "Doctor Login" : "Doctor Register",

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// Form Card
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(20),

                      child: Column(
                        children: [
                          if (!isLogin)
                            buildTextField(nameController, "Doctor Name"),

                          if (!isLogin)
                            buildTextField(
                              designationController,
                              "Designation",
                            ),

                          if (!isLogin)
                            buildTextField(hospitalController, "Hospital"),

                          if (!isLogin)
                            buildTextField(contactController, "Contact Number"),

                          buildTextField(emailController, "Email"),

                          buildTextField(
                            passwordController,
                            "Password",
                            obscure: true,
                          ),

                          const SizedBox(height: 20),

                          /// Animated Button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            width: double.infinity,
                            height: 50,

                            child: ElevatedButton(
                              onPressed: submit,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              child: Text(
                                isLogin ? "Login" : "Register",

                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },

                            child: Text(
                              isLogin
                                  ? "Create New Account"
                                  : "Already Registered?",

                              style: const TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
