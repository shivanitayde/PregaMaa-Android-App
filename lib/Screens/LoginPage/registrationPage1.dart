import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pregmaa/Screens/LoginPage/loginPage.dart';
import 'package:pregmaa/Screens/LoginPage/registrationPage2.dart';

class registerpage1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _registerpage1();
}

class _registerpage1 extends State<registerpage1> {
  var emailtext = TextEditingController();
  var passtext = TextEditingController();
  var nametext = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.pink.shade50,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150),

            SizedBox(
              height: 100,
              width: 200,
              child: Image.asset('assets/images/onBoardingImages/pregamaa.png'),
            ),

            SizedBox(height: 70),

            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  "Enter your Name",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Container(
              width: 350,
              child: TextField(
                controller: nametext,

                keyboardType: TextInputType.name,
                cursorColor: Colors.white70,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),

                    borderSide: BorderSide(
                      color: Colors.pink.shade200,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(color: Colors.white70, width: 1),
                  ),
                  // prefixText: "",
                  hintText: "Enter Name",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 40),

            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  "E-Mail",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Container(
              width: 350,
              child: TextField(
                controller: emailtext,

                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.white70,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),

                    borderSide: BorderSide(
                      color: Colors.pink.shade200,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(color: Colors.white70, width: 1),
                  ),
                  // prefixText: "",
                  hintText: "Enter E-Mail",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(height: 40),

            Row(
              children: [
                SizedBox(width: 50),
                Text(
                  " Create Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Container(
              width: 350,

              child: TextField(
                controller: passtext,
                obscureText: !_isPasswordVisible,
                obscuringCharacter: "*",

                keyboardType: TextInputType.text,
                cursorColor: Colors.white70,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(
                      color: Colors.pink.shade200,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(color: Colors.white70, width: 1),
                  ),
                  // prefixText: "",
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: 200,

              child: ElevatedButton(
                onPressed: () {
                  String uemail = emailtext.text.toString();
                  String upass = passtext.text.toString();
                  String uname = nametext.text.toString();
                  print("Email: $uemail, Pass: $upass, name: $uname");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => registerpage2()),
                  );
                },
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.pink.shade200),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account?"),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.pink.shade200),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
