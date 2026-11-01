import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:homework/models/book.dart';
import 'package:homework/models/publisher.dart';
import 'package:homework/pages/author_details_screen.dart';
import 'package:homework/pages/book_details_screen.dart';
import 'package:homework/pages/publisher_details_screen.dart';
import 'package:homework/server/general_service.dart';
import 'package:homework/themes/app_colors.dart';
import 'package:homework/widgets/custom_text_form_field.dart';

enum SearchType { book, author, publisher }

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final GeneralService _service = GeneralService();
  final TextEditingController _serachController = TextEditingController();

  SearchType _currentSearchType = SearchType.book;
  String _searchQuery = '';

  List<String> _mockResults = [];

  void _performSearch(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _searchQuery = query;
    });

    try {
      if (_currentSearchType == SearchType.book) {
        final response = await _service.searchBooksByTitle(query);
        final results = response["results"] as List;

        setState(() {
          _mockResults = results.map((b) => b["Title"].toString()).toList();
        });
      } else if (_currentSearchType == SearchType.author) {
        final response = await _service.searchAuthors(query);
        final authors = response["authors"] as List;

        setState(() {
          _mockResults =
              authors.map((a) => "${a["Fname"]} ${a["Lname"]}").toList();
        });
      } else if (_currentSearchType == SearchType.publisher) {
        final response = await _service.searchPublishers(query);
        final List<Publisher> publishers =
            response["publishers"] as List<Publisher>;

        log(publishers[0].pname);

        setState(() {
          _mockResults = publishers.map((p) => p.pname).toList();
        });
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        _mockResults = [];
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(" failed search: $e")),
      );
    }
  }

  Widget _buildChip(SearchType type, String label) {
    return ChoiceChip(
      selectedColor: AppColors.primaryColor,
      label: Text(label),
      selected: _currentSearchType == type,
      onSelected: (bool selected) {
        if (selected) {
          setState(() {
            _currentSearchType = type;
            _mockResults = [];
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Search',
          style: TextStyle(color: AppColors.primaryColor),
        ),
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: _serachController,
                  onFieldSubmitted: _performSearch,
                  textInputType: TextInputType.text,
                  prefixIcon: Icons.search,
                  hint: 'Search here',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter word to search';
                    }
                    return null;
                  },
                  label: 'Search',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildChip(SearchType.book, "book"),
                    _buildChip(SearchType.author, "Author"),
                    _buildChip(SearchType.publisher, "Publisher"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: _mockResults.isEmpty && _searchQuery.isNotEmpty
          ? Center(child: Text('No Result for"$_searchQuery"'))
          : ListView.builder(
              itemCount: _mockResults.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      shape: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor)),
                      title: Text(_mockResults[index]),
                      onTap: () async {
                        if (_currentSearchType == SearchType.book) {
                          final response =
                              await _service.searchBooksByTitle(_searchQuery);
                          final fullResult = response["results"][index];
                          Book book = Book(
                            id: fullResult['Id'],
                            title: fullResult['Title'],
                            authorFirstName: fullResult['FName'],
                            authorLastName: fullResult['Lname'],
                            publisherName: fullResult['PName'],
                            pubCity: fullResult['City'],
                            authCountry: fullResult['Country'],
                            price: fullResult['Price'],
                            type: fullResult['Type'],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookDetailsScreen(book: book),
                            ),
                          );
                        } else if (_currentSearchType == SearchType.author) {
                          final response =
                              await _service.searchAuthors(_searchQuery);
                          final author = response["authors"][index];
                          final books = response["booksByFirstAuthor"];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AuthorDetailsScreen(
                                author: author,
                                books: books,
                              ),
                            ),
                          );
                        } else if (_currentSearchType == SearchType.publisher) {
                          final response =
                              await _service.searchPublishers(_searchQuery);
                          final Publisher publisher =
                              response["publishers"][index];
                          final List<Book> books = response["books"];

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PublisherDetailsScreen(
                                publisher: publisher,
                                books: books,
                              ),
                            ),
                          );
                        }
                      },
                    ));
              },
            ),
    );
  }
}
