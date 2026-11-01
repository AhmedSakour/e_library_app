import 'dart:convert';

import 'package:homework/server/api_config.dart';
import 'package:homework/server/auth_service.dart';
import 'package:http/http.dart' as http;

class AdminService {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>> _sendProtectedPost(
      String endpoint, Map<String, dynamic> body) async {
    final token = await _authService.getToken();

    if (token == null) {
      throw Exception(
          'Please log in with administrator privileges to continue.');
    }

    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return data;
    } else if (response.statusCode == 403) {
      throw Exception(
          'You do not have sufficient permissions to perform this action.');
    } else {
      throw Exception(data['message'] ?? 'Failed to add data.');
    }
  }

  Future<String> addAuthor(Map<String, dynamic> authorData) async {
    final result = await _sendProtectedPost(
      ApiConfig.addAuthorUrl,
      authorData,
    );
    return result['message'] as String;
  }

  Future<String> addPublisher(Map<String, dynamic> publisherData) async {
    final result = await _sendProtectedPost(
      ApiConfig.addPublisherUrl,
      publisherData,
    );
    return result['message'] as String;
  }

  Future<bool> addBook({
    required String title,
    required String type,
    required double price,
    required int authorId,
    required int pubId,
  }) async {
    final data = await _sendProtectedPost(
      ApiConfig.addBookUrl,
      {
        'Title': title,
        'Type': type,
        'Price': price,
        'AuthorId': authorId,
        'pubId': pubId,
      },
    );

    return data['message'] == "Book added successfully";
  }
}
