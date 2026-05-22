import 'package:flutter/material.dart';

import 'package:pregmaa/screens/profile/profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
          ),
          title: Text(
            'Setting',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconRow(text: 'Unit of Measure', onTap: () {}),
              SizedBox(height: 8),
              _buildDivider(),
              IconRow(text: 'Notification', onTap: () {}),
              SizedBox(height: 8),
              _buildDivider(),
              IconRow(text: 'Language', onTap: () {}),
              SizedBox(height: 8),
              _buildDivider(),
              IconRow(text: 'Contact Us', onTap: () {}),
              SizedBox(height: 8),
              _buildDivider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[700], thickness: 1);
  }
}
