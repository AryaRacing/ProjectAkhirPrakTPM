import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:debook/themes.dart';
import '/../controller/session_manager.dart';
import '../home/pages/login_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Unknown User';
    });
  }

  Future<void> _logout() async {
    SessionManager sessionManager = SessionManager();
    await sessionManager.endService();

    // Navigate to LoginPage and remove all previous routes
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: semiBoldText20.copyWith(color: whiteColor),
        ),
        backgroundColor: greenColor,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile-pic.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    username,
                    style: semiBoldText20,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Email',
              style: semiBoldText16.copyWith(color: greyColor),
            ),
            const SizedBox(height: 5),
            Text(
              username,
              style: regularText16,
            ),
            Divider(height: 30, color: greyColor),
            Text(
              'Phone',
              style: semiBoldText16.copyWith(color: greyColor),
            ),
            const SizedBox(height: 5),
            Text(
              '+1 234 567 890',
              style: regularText16,
            ),
            Divider(height: 30, color: greyColor),
            Text(
              'Address',
              style: semiBoldText16.copyWith(color: greyColor),
            ),
            const SizedBox(height: 5),
            Text(
              '123 Main Street, Hometown, Country',
              style: regularText16,
            ),
            Divider(height: 30, color: greyColor),
            Text(
              'Bio',
              style: semiBoldText16.copyWith(color: greyColor),
            ),
            const SizedBox(height: 5),
            Text(
              'Book lover, avid reader, and aspiring author.',
              style: regularText16,
            ),
          ],
        ),
      ),
    );
  }
}
