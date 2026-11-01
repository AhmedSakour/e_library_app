import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homework/constant/app_routes.dart';
import 'package:homework/pages/admin_home_screen.dart';
import 'package:homework/pages/book_list_screen.dart';
import 'package:homework/server/auth_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  LoginScreen({super.key});
  final AuthService _authService = AuthService();
  void _submitLogin(BuildContext context) async {
    log(_usernameController.text);
    log(_passwordController.text);
    try {
      final user = await _authService.login(
        _usernameController.text.trim(),
        _passwordController.text.trim(),
      );
      log('success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Succes Login')),
      );
      user!.isAdmin
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHomeScreen(),
              ))
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookListScreen(),
              ));
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign in',
          style: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  'Welcome to our online library',
                  style: TextStyle(
                    color: Color(0xFFDA8506),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
              CustomTextFormField(
                controller: _usernameController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                hint: 'User Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your name';
                  }
                  return null;
                },
                label: 'User Name',
              ),

              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _passwordController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.lock,
                hint: 'password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter your password';
                  }
                  return null;
                },
                label: 'password',
              ),

              const SizedBox(height: 30),
              CustomPrimaryButton(
                text: 'log in',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _submitLogin(context);
                  }
                },
              ),
              //
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text('Don\'t have an account?'),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.signUp),
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(color: AppColors.primaryColor),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
