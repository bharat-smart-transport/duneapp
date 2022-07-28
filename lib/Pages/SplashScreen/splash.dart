import 'dart:async';
import 'package:dune/Pages/Auth/login.dart';
import 'package:dune/Pages/Auth/login_as_page.dart';
import 'package:dune/Pages/HomePage/homepage.dart';
import 'package:dune/Pages/OnBoarding/splashscreen.dart';
import 'package:dune/Provider/main_provider.dart';
import 'package:dune/Services/essentials.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void navigateToSplash() async {
    String token = await SharedPrefs.getData("token");
    if (token.isNotEmpty) {
      final dynamic res =
          // ignore: use_build_context_synchronously
          await Provider.of<MainProvider>(context, listen: false).splashFun();
      if (res == "Failed") {
        Timer(const Duration(seconds: 1), () {
          SharedPrefs.removeUser();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        });
      }
    }
    token.isEmpty
        ? Timer(const Duration(seconds: 3), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SplashScreen()));
          })
        : mounted
            ? Timer(const Duration(seconds: 3), () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              })
            : navigateToSplash();
  }

  @override
  void initState() {
    if (mounted) {
      navigateToSplash();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Essentials.hexToColor("#ffffff"),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                "Dune",
                style: Theme.of(context).textTheme.headline1,
              )),
          Positioned(
            bottom: 100,
            right: -50,
            child: Image.asset(
              "assets/splash_screen.png",
              height: 280,
            ),
          ),
        ],
      ),
    );
  }
}
