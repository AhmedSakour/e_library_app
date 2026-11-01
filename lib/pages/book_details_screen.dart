import 'package:flutter/material.dart';
import 'package:homework/models/book.dart';
import 'package:homework/themes/app_colors.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Text('Title:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(book.title,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor)),
                ],
              ),
              Divider(
                color: AppColors.secondaryColor,
              ),
              _buildDetailRow(label: 'Type', value: book.type!),
              _buildDetailRow(label: 'Price', value: '${book.price} \$'),
              const SizedBox(height: 20),
              _buildSectionCard(
                title: 'Publishers data',
                details: [
                  _buildDetailRow(
                      label: 'Publishers name', value: book.publisherName!),
                  _buildDetailRow(label: 'City', value: book.pubCity ?? 'a'),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionCard(
                title: 'Author data',
                details: [
                  _buildDetailRow(
                      label: 'Name',
                      value: '${book.authorFirstName} ${book.authorLastName}'),
                  _buildDetailRow(
                      label: 'Country', value: book.authCountry ?? 'b'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text('$label: ',
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.primaryColor)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
      {required String title, required List<Widget> details}) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            ...details,
          ],
        ),
      ),
    );
  }
}
