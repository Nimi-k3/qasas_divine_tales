// part of '../core.dart';

// class AuthApi {

//   static const String baseUrl = 'http://127.0.0.1:5000/api/auth';

//   static Future<Map<String, dynamic>> register(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/register'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     return jsonDecode(response.body);
//   }

// static Future<Map<String, dynamic>> login(String email, String password) async {
//   try {
//     final response = await http.post(
//       Uri.parse('$baseUrl/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     ).timeout(const Duration(seconds: 8));

//     return jsonDecode(response.body);
//   } catch (e) {
//     return {'error': 'Login failed'};
//   }
// }


// }
part of '../core.dart';

class AuthApi {
  static const String baseUrl = 'http://127.0.0.1:5000/api/auth';

  /// 1️⃣ Register
  static Future<Map<String, dynamic>> register(
      String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 8));

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Registration failed'};
    }
  }

  /// 2️⃣ Login
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 8));

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Login failed'};
    }
  }

  /// 3️⃣ Get User Profile
  static Future<Map<String, dynamic>> getProfile(int userId) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/profile/$userId'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 8));

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Failed to fetch profile'};
    }
  }

  /// 4️⃣ Logout
  static Future<Map<String, dynamic>> logout(int userId) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/logout'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'user_id': userId}),
          )
          .timeout(const Duration(seconds: 8));

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Logout failed'};
    }
  }

  /// 5️⃣ Delete Account
  static Future<Map<String, dynamic>> deleteAccount(int userId) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl/delete-account'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'user_id': userId}),
          )
          .timeout(const Duration(seconds: 8));

      return jsonDecode(response.body);
    } catch (e) {
      return {'error': 'Account deletion failed'};
    }
  }
}
