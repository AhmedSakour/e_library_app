import 'package:flutter/material.dart';
import 'package:homework/server/admin_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_primary_button.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

class AddPublisherScreen extends StatelessWidget {
  final TextEditingController _pnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  AddPublisherScreen({super.key});

  final AdminService _adminService = AdminService();
  final formKey = GlobalKey<FormState>();
  void _submitPublisher(BuildContext context) async {
    final publisherData = {
      'PName': _pnameController.text.trim(),
      'City': _cityController.text.trim(),
    };

    try {
      final message = await _adminService.addPublisher(publisherData);

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
          'Add a new publisher',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: <Widget>[
              CustomTextFormField(
                controller: _pnameController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.person,
                hint: 'Publisher Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter publisher name';
                  }
                  return null;
                },
                label: 'Publisher Name',
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                controller: _cityController,
                textInputType: TextInputType.text,
                prefixIcon: Icons.location_city_outlined,
                hint: ' City',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter the city';
                  }
                  return null;
                },
                label: ' City',
              ),
              const SizedBox(height: 30),
              CustomPrimaryButton(
                text: 'Save',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _submitPublisher(context);
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
