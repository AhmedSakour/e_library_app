import 'package:flutter/material.dart';
import 'package:homework/constant/app_routes.dart';
import 'package:homework/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin();

    super.initState();
  }

  void goToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      try {
        Navigator.pushNamed(context, AppRoutes.onboarding);
      } on Exception {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assests/images/library.png"),
            fit: BoxFit.cover, // makes the image fill the screen
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(90)),
                child: Image.asset('assests/images/Vector.png')),
            Text(
              " Albrain Books",
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              color: AppColors.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
