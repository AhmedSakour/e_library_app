import 'package:flutter/material.dart';
import 'package:homework/constant/app_routes.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Image.asset('assests/images/Vector.png'),
                Text(
                  'Welcome to \n Albrain Books',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.menu_book_rounded,
                    size: 150,
                    color: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus in.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus in.Lorem ipsum dolor sit amet, consectetur ad',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                CustomPrimaryButton(
                  text: 'Get Started',
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.login),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
