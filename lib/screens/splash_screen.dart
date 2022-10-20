import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellthedwell/providers/auth_provider.dart';
import 'package:sellthedwell/routes.dart';
import 'package:sellthedwell/services/network_service.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/util_methods.dart';
import 'package:sellthedwell/widgets/circular_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late BuildContext _context;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _checkLocalLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Konstants.splashPath,
            fit: BoxFit.cover,
          ),
          const Positioned(
            bottom: 64,
            right: 16,
            left: 16,
            child: CircularProgressWidget(),
          ),
        ],
      ),
    );
  }

  void _checkLocalLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Show onboardpage for firsttime customers.
      if (prefs.getBool(Konstants.keyFirstTime) ?? true) {
        await prefs.setBool(Konstants.keyFirstTime, false);
        CommonMethods.removeAllRoutesAndPushNamed(
            routeName: Routes.onboard, context: _context);
      }

      // Reloading the app
      final result = await NetworkService.login(
        email: prefs.getString(Konstants.keyEmail) ?? "",
        password: prefs.getString(Konstants.keyPassword) ?? "",
      );
      if (mounted) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
        auth.setLoginResponse(result);
        await auth.saveToken(token: result['token']);
        await prefs.setString("name", result['user_data']['name']);
        await prefs.setString("address", result['user_data']['address']);
        await prefs.setString("country", result['user_data']['country']);
        await prefs.setString("phone", result['user_data']['phone']);
        await prefs.setString("state", result['user_data']['state']);
        await prefs.setString("postalCode", result['user_data']['zipcode']);

        // Login details found, going to main screen
        CommonMethods.removeAllRoutesAndPushNamed(
            routeName: Routes.main, context: _context);
      }
    } catch (e) {
      log("Exception: ${e.toString()}");
      // Going to login if any exception.
      CommonMethods.removeAllRoutesAndPushNamed(
          routeName: Routes.login, context: _context);
    }
  }
}
