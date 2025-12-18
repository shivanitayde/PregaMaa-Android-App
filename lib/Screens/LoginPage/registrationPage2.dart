import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pregmaa/Screens/HomePage/homeScreen.dart';
import 'package:pregmaa/Screens/OnBoardingPage/onboardingScreen.dart';

class registerpage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _registerpage2();
}

class _registerpage2 extends State<registerpage2> {
  var nametext = TextEditingController();
  var dobcontroller = TextEditingController();
  var lmpcontroller = TextEditingController();
  var mobcontroller = TextEditingController();
  var addcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.pink.shade50,
          child: Column(
            children: [
              SizedBox(height: 100),
              SizedBox(
                height: 100,
                width: 200,
                child: Image.asset(
                  'assets/images/onBoardingImages/pregamaa.png',
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Name",
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
                    "Date Of Birth",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Container(
                width: 350,
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: dobcontroller,

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
                    hintText: "dd/mm/yyyy",
                    prefixIcon: Icon(Icons.date_range),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Last Menstrual Period (LMP)",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Container(
                width: 350,
                child: TextField(
                  controller: lmpcontroller,
                  keyboardType: TextInputType.datetime,
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
                    hintText: "dd/mm/yyyy",
                    prefixIcon: Icon(Icons.bloodtype_sharp),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  SizedBox(width: 50),
                  Text(
                    "Mobile No.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Container(
                width: 350,
                child: TextField(
                  controller: mobcontroller,
                  keyboardType: TextInputType.phone,
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
                    hintText: "Enter Mobile no.",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  SizedBox(width: 40),
                  Text(
                    "Address:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Container(
                width: 350,
                child: TextField(
                  controller: addcontroller,
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
                    hintText: "Enter address",
                    prefixIcon: Icon(Icons.location_city),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Container(
                width: 200,

                child: ElevatedButton(
                  onPressed: () {
                    String umob = mobcontroller.text.toString();
                    String uadd = addcontroller.text.toString();
                    String uname = nametext.text.toString();
                    print("mob: $umob, Add: $uadd, name: $uname");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Homescreen()),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(color: Colors.pink.shade200),
                  ),
                ),
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
