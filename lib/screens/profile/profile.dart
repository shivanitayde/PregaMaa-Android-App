import 'package:flutter/material.dart';
import 'package:pregmaa/model/pregnancy_user.dart';
import 'package:pregmaa/services/user_storage.dart';
import 'package:pregmaa/screens/login/login.dart';
import 'package:pregmaa/screens/personal info/personal_info_screen.dart';
import 'package:pregmaa/screens/profile/profilesetting.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  PregnancyUser? user;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  /// 🔹 Load Saved User Data
  Future<void> loadUserData() async {
    PregnancyUser? savedUser = await UserStorage.getUser();

    setState(() {
      user = savedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.amber[100],

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },

          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.055,

          vertical: MediaQuery.of(context).size.height * 0.02,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// Profile Top
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                CircleAvatar(backgroundColor: Colors.amber[100], radius: 50),

                RotatedBox(
                  quarterTurns: 1,
                  child: Divider(color: Colors.black, thickness: 2),
                ),

                Container(
                  width: 180,
                  height: 90,
                  padding: EdgeInsets.all(10),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        'Joined',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),

                      Text(
                        'June 2025',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            /// 🔥 USER NAME
            Text(
              user?.name ?? "User Name",

              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),

            /// 🔥 AGE + WEEK
            Text(
              "Age: ${user?.age ?? '-'}   Week: ${user?.pregnancyWeek ?? '-'}",

              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 20),

            _buildDivider(),

            /// 🔥 EDIT PROFILE
            IconRow(
              text: " Edit Profile",

              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInfoScreen()),
                );

                /// Reload updated data
                loadUserData();
              },
            ),

            SizedBox(height: 8),

            _buildDivider(),

            SizedBox(height: 8),

            IconRow(
              text: 'Privacy Policy',
              onTap: () {
                Navigator.pushNamed(context, '/privacy&policy');
              },
            ),

            SizedBox(height: 8),

            _buildDivider(),

            SizedBox(height: 8),

            IconRow(
              text: 'Setting',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingPage()),
                );
              },
            ),

            SizedBox(height: 8),

            _buildDivider(),

            SizedBox(height: 7),

            /// Sign Out
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },

              child: Text(
                'Sign Out',

                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),

            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[700], thickness: 1);
  }
}

class IconRow extends StatelessWidget {
  const IconRow({super.key, required this.text, required this.onTap});

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },

      child: Container(
        height: 50,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(text, style: TextStyle(fontSize: 20, color: Colors.black)),

            Padding(
              padding: EdgeInsets.all(8),

              child: Icon(Icons.arrow_forward_ios, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
