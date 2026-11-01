import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homework/constant/app_routes.dart';
import 'package:homework/server/auth_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  void _submitSignup(BuildContext context) async {
    log(_usernameController.text);
    try {
      await _authService.signup(
        username: _usernameController.text,
        password: _passwordController.text,
        fName: _firstNameController.text,
        lName: _lastNameController.text,
      );
      log('success');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Create account succesfully, login now')),
      );
      Navigator.pop(context);
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
        title: const Text('Sign Up'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
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
              const SizedBox(height: 15),
              CustomTextFormField(
                  controller: _firstNameController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.contact_page_rounded,
                  hint: 'First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first Name';
                    }
                    return null;
                  },
                  label: 'First Name'),
              const SizedBox(height: 20),
              CustomTextFormField(
                  controller: _lastNameController,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.contact_page_rounded,
                  hint: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last Name';
                    }
                    return null;
                  },
                  label: 'Last Name'),
              const SizedBox(height: 30),
              CustomPrimaryButton(
                text: 'Sign Up',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _submitSignup(context);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text('Already have an account?'),
                  GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                      child: Text(
                        ' Login',
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
