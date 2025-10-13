import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),

        titleTextStyle: TextStyle(fontSize: 30, color: Colors.black),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        //ToDO List--
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.02),
                //ToDO List--
                ListOfFeatures(
                  name: "todo List",
                  im1: 'assets/images/HomePageImages/todo.png',
                  c1: const Color.fromARGB(255, 244, 184, 213),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.02),
                //Entertainment
                ListOfFeatures(
                  name: "Entertainment",
                  im1: 'assets/images/HomePageImages/Entertain.png',
                  c1: const Color.fromARGB(255, 229, 163, 240),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.02),
                //Nutrition
                ListOfFeatures(
                  name: "Nutrition",
                  im1: 'assets/images/HomePageImages/Nutrition.png',
                  c1: const Color.fromARGB(255, 184, 147, 187),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.02),
                //Meditation
                ListOfFeatures(
                  name: "Meditation",
                  im1: 'assets/images/HomePageImages/Meditation.png',
                  c1: const Color.fromARGB(255, 154, 174, 174),
                  c2: const Color.fromARGB(255, 3, 53, 4),
                ),
                SizedBox(height: size.height * 0.02),
                //vaccination
                ListOfFeatures(
                  name: "Vaccination",
                  im1: 'assets/images/HomePageImages/vaccination.png',
                  c1: const Color.fromARGB(255, 232, 194, 181),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.02),
                //Exercise & yoga
                ListOfFeatures(
                  name: "Exercise & Yoga",
                  im1: 'assets/images/HomePageImages/Yoga.png',
                  c1: const Color.fromARGB(255, 240, 142, 113),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.02),
                //My Documents
                ListOfFeatures(
                  name: "My Documents",
                  im1: 'assets/images/HomePageImages/documents.png',
                  c1: const Color.fromARGB(255, 172, 245, 175),
                  c2: Colors.brown,
                ),
                SizedBox(height: size.height * 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfFeatures extends StatelessWidget {
  const ListOfFeatures({
    super.key,
    required this.name,

    required this.c1,
    required this.im1,
    required this.c2,
  });

  final String name;
  final Color c2;
  final Color c1;
  final String im1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      width: size.width * 0.9,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: c1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 30,
              color: c2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: size.height * 0.4,
            width: size.width * 0.3,

            child: Image.asset(im1, height: 600, width: 500, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
