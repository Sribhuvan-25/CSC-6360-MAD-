import 'package:text_messaging/pages/change_loginInfo_page.dart';
import 'package:text_messaging/pages/edit_personal_information.dart';
import 'package:text_messaging/utils/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PersonalInfoChangePage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Change DOB",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => ChangeLoginInfoPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Change email",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              onTap: signOut,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
