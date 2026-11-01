import 'package:flutter/material.dart';
import 'package:homework/themes/app_colors.dart';

class AuthorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> author;
  final List<dynamic> books;

  const AuthorDetailsScreen({
    super.key,
    required this.author,
    required this.books,
  });
  Widget infoAuthor(String label, String value) {
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
              style: const TextStyle(
                fontSize: 18,
              ),
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
            "${author["Fname"]} ${author["Lname"]}",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoAuthor("Name", "${author["Fname"]} ${author["Lname"]}"),
            infoAuthor("Country", author["Country"]),
            infoAuthor("City", author["City"]),
            infoAuthor("Address", author["Address"]),
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
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                    },
                    children: [
                      const TableRow(
                        decoration: BoxDecoration(color: Colors.black12),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Title",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Type",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text("Price",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      ...books.map(
                        (b) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(b["Title"]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(b["Type"]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text("\$${b["Price"]}"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Text(
                    "No books for this author",
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
