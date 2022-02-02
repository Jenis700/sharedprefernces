import 'package:flutter/material.dart';
import 'package:my_login_app/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences loginGetdata;
  String? email;
  String? password;
  String? address;
  String? phone;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    loginGetdata = await SharedPreferences.getInstance();
    setState(() {
      email = loginGetdata.getString("email");
      password = loginGetdata.getString("password");
      address = loginGetdata.getString("address");
      phone = loginGetdata.getString("phone");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Welcome Back!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: Text("Log Out"),
            )
          ],
        ),
      ),
    );
  }
}
