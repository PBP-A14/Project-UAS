import 'dart:convert';
import 'package:http/http.dart' as http;

class ProgressApiService {
  static const baseUrl = 'http://127.0.0.1:8000/';
  static const progressUrl = 'progress_literasi/progress/';

  Future<String> getActiveTime() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$progressUrl'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['activeTime'];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }
}
