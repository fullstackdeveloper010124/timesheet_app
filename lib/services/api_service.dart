import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config.dart';

class ApiService {
  // Get the base URL from configuration
  static String get baseUrl => AppConfig.apiUrl;

  // Headers for API requests
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Get headers with authorization token
  static Future<Map<String, String>> getAuthHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Map<String, String> authHeaders = Map.from(headers);
    if (token != null) {
      authHeaders['Authorization'] = 'Bearer $token';
    }
    return authHeaders;
  }

  // Generic HTTP GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = '$baseUrl$endpoint';
      if (AppConfig.enableLogging) {
        print('🌐 GET Request: $url');
      }

      final response = await http.get(
        Uri.parse(url),
        headers: await getAuthHeaders(),
      );

      return _handleResponse(response);
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ GET Error: $e');
      }
      throw Exception('Network error: $e');
    }
  }

  // Generic HTTP POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final url = '$baseUrl$endpoint';
      if (AppConfig.enableLogging) {
        print('🌐 POST Request: $url');
        print('📤 Data: ${json.encode(data)}');
      }

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      if (AppConfig.enableLogging) {
        print('❌ POST Error: $e');
      }
      throw Exception('Network error: $e');
    }
  }

  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body);

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody;
    } else {
      // Handle error response
      String errorMessage = 'An error occurred';

      if (responseBody is Map<String, dynamic>) {
        errorMessage = responseBody['error'] ??
            responseBody['message'] ??
            'An error occurred';
      }

      throw Exception(errorMessage);
    }
  }

  // Save token to shared preferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Save user data to shared preferences
  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user));
  }

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Get stored user data
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      return json.decode(userString);
    }
    return null;
  }

  // Clear stored data (logout)
  static Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('user');
  }
}

// Auth API class
class AuthAPI {
  // User signup (Admin/Manager)
  static Future<Map<String, dynamic>> userSignup({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    final data = {
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'role': role,
    };

    return await ApiService.post('/auth/user/signup', data);
  }

  // Team member signup (Employee)
  static Future<Map<String, dynamic>> memberSignup({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    String? project,
  }) async {
    final data = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'role': role,
      'project': project ?? '507f1f77bcf86cd799439011', // Default project ID
    };

    return await ApiService.post('/auth/member/signup', data);
  }

  // Login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final data = {
      'email': email,
      'password': password,
    };

    return await ApiService.post('/auth/login', data);
  }

  // Forgot password
  static Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final data = {
      'email': email,
    };

    return await ApiService.post('/auth/forgot-password', data);
  }
}
