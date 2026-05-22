import 'package:flutter/material.dart';
import 'package:pregmaa/screens/doctor%20dashboard/doctor_dashboard.dart';
import 'package:pregmaa/screens/login/register.dart';
import 'package:pregmaa/screens/login/forgot_password.dart';
import 'package:pregmaa/screens/personal info/personal_info_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login_sign_upState();
}

class _Login_sign_upState extends State<Login>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  late PageController _pageController;

  bool isLoginSelected = true;

  /// NEW → Role selection
  String selectedRole = "patient";

  /// Animation
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Default Credentials
  final String defaultUsername = "admin";
  final String defaultPassword = "1234";

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);

    _animationController.forward();
  }

  /// LOGIN FUNCTION
  void loginUser() {
    String username = _emailController.text.trim();

    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter Username and Password"),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    /// PATIENT LOGIN
    if (selectedRole == "patient") {
      if (username == defaultUsername && password == defaultPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PersonalInfoScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Username or Password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    /// DOCTOR LOGIN
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DoctorDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      body: FadeTransition(
        opacity: _fadeAnimation,

        child: Stack(
          children: [
            /// Image
            Positioned(
              top: size.height * 0.27,
              left: size.width * 0.02,
              right: size.width * 0.02,

              child: AnimatedScale(
                duration: const Duration(milliseconds: 600),
                scale: 1,

                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.greenAccent,

                  backgroundImage: const AssetImage('assets/images/login.jpg'),
                ),
              ),
            ),

            /// Title
            Positioned(
              top: size.height * 0.49,
              left: size.width * 0.01,
              right: size.width * 0.01,

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Text(
                  "WELCOME TO MOTHERHOOD",

                  style: TextStyle(
                    fontSize: size.height * 0.027,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// Form Area
            Positioned(
              left: 0,
              right: 0,
              top: size.height * 0.6,

              child: SizedBox(
                height: size.height * 0.5,

                child: PageView(
                  controller: _pageController,

                  onPageChanged: (index) {
                    setState(() {
                      isLoginSelected = index == 0;
                    });
                  },

                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),

                      child: Column(
                        children: [
                          /// ROLE SELECTOR (NEW)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedRole = "patient";
                                    });
                                  },

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedRole == "patient"
                                        ? Colors.pink
                                        : Colors.grey,
                                  ),

                                  child: const Text("Patient"),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedRole = "doctor";
                                    });
                                  },

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedRole == "doctor"
                                        ? Colors.pink
                                        : Colors.grey,
                                  ),

                                  child: const Text("Doctor"),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.03),

                          /// Username
                          TextField(
                            controller: _emailController,

                            decoration: const InputDecoration(
                              hintText: 'UserName',
                            ),
                          ),

                          SizedBox(height: size.height * 0.03),

                          /// Password
                          TextField(
                            controller: _passwordController,

                            obscureText: true,

                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                          ),

                          const SizedBox(height: 5),

                          /// Forgot + Register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ForgotPasswordScreen(),
                                    ),
                                  );
                                },

                                child: const Text("Forgot Password?"),
                              ),

                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ),
                                  );
                                },

                                child: const Text("New? Register"),
                              ),
                            ],
                          ),

                          SizedBox(height: size.height * 0.01),

                          /// Animated Login Button
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),

                            width: double.infinity,

                            child: ElevatedButton(
                              onPressed: loginUser,

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,

                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                              ),

                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    _pageController.dispose();

    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }
}
