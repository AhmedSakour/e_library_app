import 'package:flutter/material.dart';
import 'package:homework/server/admin_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

class AddAuthorScreen extends StatelessWidget {
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  AddAuthorScreen({super.key});

  final AdminService _adminService = AdminService();

  void _submitAuthor(BuildContext context) async {
    final newAuthorData = {
      'Fname': _fnameController.text.trim(),
      'Lname': _lnameController.text.trim(),
      'Country': _countryController.text.trim(),
      'City': _cityController.text.trim(),
      'Address': _addressController.text.trim(),
    };

    try {
      final message = await _adminService.addAuthor(newAuthorData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
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
          'Add New Author',
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                controller: _fnameController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                hint: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter first name';
                  }
                  return null;
                },
                label: 'First Name',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _lnameController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                hint: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter last name';
                  }
                  return null;
                },
                label: 'Last Name',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _countryController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.location_city,
                hint: 'Country',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter country';
                  }
                  return null;
                },
                label: 'Country',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _cityController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.location_city,
                hint: 'City',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter city';
                  }
                  return null;
                },
                label: 'City',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _addressController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.house,
                hint: 'Address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter address';
                  }
                  return null;
                },
                label: 'Address',
              ),
              const SizedBox(height: 30),
              CustomPrimaryButton(
                text: 'Save Author',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _submitAuthor(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
