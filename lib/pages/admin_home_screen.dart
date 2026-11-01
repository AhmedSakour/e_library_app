import 'package:flutter/material.dart';
import 'package:homework/pages/add_author_screen.dart';
import 'package:homework/pages/add_book_screen.dart';
import 'package:homework/pages/add_publisher_screen.dart';
import 'package:homework/themes/app_colors.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  Widget _buildButton(
      BuildContext context, IconData icon, String title, Widget page) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: AppColors.primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Dashboard",
          style: TextStyle(color: AppColors.primaryColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildButton(context, Icons.book, "Add Book", const AddBookScreen()),
          const SizedBox(
            height: 30,
          ),
          _buildButton(
              context, Icons.person_add, "Add Author", AddAuthorScreen()),
          const SizedBox(
            height: 30,
          ),
          _buildButton(
              context, Icons.publish, "Add publisher", AddPublisherScreen()),
        ],
      ),
    );
  }
}
