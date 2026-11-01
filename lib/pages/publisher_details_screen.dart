import 'package:flutter/material.dart';
import 'package:homework/models/book.dart';
import 'package:homework/models/publisher.dart';
import 'package:homework/themes/app_colors.dart';

class PublisherDetailsScreen extends StatelessWidget {
  final Publisher publisher;
  final List<Book> books;

  const PublisherDetailsScreen({
    super.key,
    required this.publisher,
    required this.books,
  });

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontSize: 18,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          publisher.pname,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoRow("Publisher", publisher.pname),
            infoRow("City", publisher.city!),
            const SizedBox(height: 20),
            const Text("Books:", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            books.isNotEmpty
                ? Table(
                    border: TableBorder.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.black12),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Title",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Author",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "Price",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      ...books.map(
                        (b) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(b.title),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "${b.authorFirstName} ${b.authorLastName}",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("\$${b.price}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Text(
                    "No books for this publisher",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: AppColors.greyColor,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
