import 'package:flutter/material.dart';
import 'package:pregmaa/Screens/LoginPage/loginPage.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.07),
            Container(
              height: size.height * 0.05,
              width: size.width * 0.3,

              child: Image.asset('assets/images/onBoardingImages/pregamaa.png'),
            ),
            SizedBox(height: size.height * 0.03),

            Container(
              height: size.height * 0.4,
              width: size.width * 1.5,

              child: Image.asset('assets/images/onBoardingImages/img1.png'),
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              'Welcome',
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              'Welcome to PregaMaa,',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              'A New Hope for Pregnant Women of India',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            SizedBox(height: size.height * 0.03),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loginpage()),
                );
              },
              child: Container(
                height: size.height * 0.05,
                width: size.width * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.pinkAccent,
                ),
                child: Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
