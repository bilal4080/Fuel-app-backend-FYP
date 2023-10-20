// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print, sized_box_for_whitespace

import 'dart:async';
import 'package:app/Admin/adminDashboard.dart';
import 'package:app/Driver/drivre_dashboard.dart';
import 'package:app/user/splashscree.dart';
import 'package:app/user/userdashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkUserAndNavigate();
  }

  Future<void> _checkUserAndNavigate() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      final email = user.email;

      try {
        final querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docSnapshot = querySnapshot.docs.first;
          final data = docSnapshot.data();
          final checkuser = data['checkuser'];

          if (checkuser == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FuelAppDashboard(),
              ),
            );
          } else if (checkuser == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => driverDashbord(),
              ),
            );
          } else if (checkuser == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserDashboardScreen(),
              ),
            );
          }
        }
      } catch (e) {
        print("Error checking user data: $e");
        // Handle the error as needed
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/Logo App.png',
                width: 200, height: 200), // Adjust width and height as needed
            SizedBox(height: 20), // Add some spacing between the image and text
            Text(
              "The Best in your Town",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, wordSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}
