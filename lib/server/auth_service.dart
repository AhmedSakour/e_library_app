import 'dart:convert';
import 'dart:developer';

import 'package:homework/models/user.dart';
import 'package:homework/server/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<void> signup({
    required String username,
    required String password,
    required String fName,
    required String lName,
  }) async {
    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.signupUrl}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Username': username,
        'password': password,
        'FName': fName,
        'LName': lName,
      }),
    );

    if (response.statusCode != 201) {
      final errorData = jsonDecode(response.body);
      log(errorData.toString());
      throw Exception(
          errorData['message'] ?? 'Account creation failed. Unknown error.');
    }
  }

  Future<User?> login(String username, String password) async {
    final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.loginUrl}');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);

        final Map<String, dynamic> userData =
            data['user'] as Map<String, dynamic>;

        userData['isAdmin'] = data['isAdmin'] == 1;

        final user = User.fromJson(userData);

        return user;
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'login failed. Unknown error.');
      }
    } catch (e) {
      log(e.toString());
      throw Exception(
          'Failed to connect to the server: The server may be unavailable.');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}
