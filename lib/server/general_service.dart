import 'dart:convert';

import 'package:homework/models/author.dart';
import 'package:homework/models/book.dart';
import 'package:homework/models/publisher.dart';
import 'package:homework/server/api_config.dart';
import 'package:http/http.dart' as http;

class GeneralService {
  final String _baseUrl = ApiConfig.baseUrl;

  Future<List<Book>> getAllBooks() async {
    final url = Uri.parse('$_baseUrl${ApiConfig.getAllBooks}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> booksJson = data['books'] as List;
      return booksJson.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to bring books. Make sure the backend is working.');
    }
  }

  Future<Map<String, dynamic>> searchBooksByTitle(String title) async {
    final url = Uri.parse('$_baseUrl${ApiConfig.searchBooks}?title=$title');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return {"results": []};
    } else {
      throw Exception('Book search failed.');
    }
  }

  Future<Map<String, dynamic>> searchAuthors(String name) async {
    final url = Uri.parse('$_baseUrl${ApiConfig.searchAuthors}?name=$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return {'authors': [], 'booksByFirstAuthor': []};
    } else {
      throw Exception('Search for authors failed.');
    }
  }

  Future<Map<String, dynamic>> searchPublishers(String name) async {
    final url = Uri.parse('$_baseUrl${ApiConfig.searchPublishers}?name=$name');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Publisher> publishers = (data['publishers'] as List)
          .map((json) => Publisher.fromJson(json))
          .toList();

      final List<Book> booksByPublisher =
          (data['booksByFirstPublisher'] as List)
              .map((json) => Book.fromJson(json))
              .toList();

      return {
        'publishers': publishers,
        'books': booksByPublisher,
      };
    } else if (response.statusCode == 404) {
      return {'publishers': [], 'books': []};
    } else {
      throw Exception('Search for publishers failed.');
    }
  }

  Future<List<Author>> getAllAuthors() async {
    final url = Uri.parse('$_baseUrl${ApiConfig.getAllAuthors}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List authorsJson = data['authors'];
      return authorsJson.map((json) => Author.fromJson(json)).toList();
    } else {
      throw Exception('Failed to bring authors.');
    }
  }

  Future<List<Publisher>> getAllPublishers() async {
    final url = Uri.parse('$_baseUrl${ApiConfig.getAllPublishers}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List publishersJson = data['publishers'];
      return publishersJson.map((json) => Publisher.fromJson(json)).toList();
    } else {
      throw Exception('Failed to bring in publishers.');
    }
  }
}
