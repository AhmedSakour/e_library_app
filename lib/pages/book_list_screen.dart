import 'package:flutter/material.dart';
import 'package:homework/models/book.dart';
import 'package:homework/pages/book_details_screen.dart';
import 'package:homework/pages/serach_result_screen.dart';
import 'package:homework/server/general_service.dart';
import 'package:homework/themes/app_colors.dart';

final GeneralService _generalService = GeneralService();

class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Electronic Library',
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchResultsScreen()));
              },
              icon: const Icon(Icons.search))
        ],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Book>>(
        future: _generalService.getAllBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('خطأ في تحميل البيانات: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final books = snapshot.data!;

            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsScreen(
                            book: books[index],
                          ),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      shape: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          )),
                      title: Text(
                        book.title,
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                      subtitle: Text('Type: ${book.type}'),
                      trailing: Text('Price: \$${book.price ?? 'N/A'}'),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('لا توجد كتب متاحة حالياً.'));
        },
      ),
    );
  }
}
