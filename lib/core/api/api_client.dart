// part of '../core.dart';

// class ApiClient {
  

//   //  static const String baseUrl = 'http://127.0.0.1:5000/api';
//   static const String baseUrl = 'http://localhost:5000/api';


//   /// Generic GET request
//   static Future<dynamic> get(String endpoint) async {
//     final uri = Uri.parse('$baseUrl$endpoint');
//     final response = await http.get(
//       uri,
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       // Decode JSON
//       final data = jsonDecode(response.body);

//       // Return List or Map depending on the response type
//       if (data is List) {
//         return data; // List of objects
//       } else if (data is Map) {
//         return data; // Single object
//       } else {
//         throw Exception('Unexpected response format');
//       }
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }


//   static Future<dynamic> post(String endpoint, Map body) async {
//     final res = await http.post(
//       Uri.parse('$baseUrl$endpoint'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(body),
//     );
//     return jsonDecode(res.body);
//   }
// }


part of '../core.dart';

class ApiClient {
  static const String baseUrl = 'http://127.0.0.1:5000/api';

  static Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(
      uri,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET failed: ${response.statusCode}');
    }
  }

  static Future<dynamic> post(String endpoint, Map body) async {
    final res = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception('POST failed: ${res.statusCode}');
    }
  }
}
