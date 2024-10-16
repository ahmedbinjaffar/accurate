// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:async';
import 'package:accurate/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:accurate/constants/asset_images.dart';
import 'package:accurate/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:accurate/screens/splash_screen/no_internet.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void _checkInternetConnection() async {
    await Future.delayed(const Duration(seconds: 5));
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomBottomBar(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NoInternetScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.25,
                width: size.width * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage(AssetsImages.instance.logoimage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.06),
              const SpinKitSquareCircle(
                color: AppClr.primaryColor,
                size: 40.0,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: size.height * 0.06,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Routes.instance.openUrl('http://uhaatech.com/');
                    },
                    child: Text(
                      "Developed by Uhaa Tech",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
