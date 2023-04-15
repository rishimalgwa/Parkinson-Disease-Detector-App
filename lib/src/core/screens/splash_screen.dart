import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pkd_app/src/features/Dashboard/presentation/pages/dashboard_screen.dart';
import 'package:pkd_app/src/features/GetStarted/presentation/pages/get_started_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences sharedPreferences;
  late bool isLoggedIn;
  @override
  void initState() {
    getAuthDetails();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  isLoggedIn ? const DashboardPage() : const GetStartedPage(),
            )));

    super.initState();
  }

  getAuthDetails() async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLoggedIn = sharedPreferences.getBool("ISLOGGED_IN_KEY") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
