import 'dart:convert';
// import 'package:elibrary/data/model/home_book_model.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class ProgressApiService {
  static const baseUrl = 'http://127.0.0.1:8000/';
  static const progressUrl = 'progress_literasi/progress/';
  static const setTargetUrl = 'progress_literasi/set_target_flutter/';
  static const readingHistoryUrl = 'my_profile/get_reading_history_json/';

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

  Future<void> setDailyTarget(int target) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$setTargetUrl'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"target_buku": target}),
      );

      if (response.statusCode == 200) {
        // Handle sukses jika perlu
        print('Target harian berhasil disimpan!');
      } else {
        throw Exception('Gagal menyimpan target harian.');
      }
    } catch (error) {
      throw Exception('Gagal terhubung ke server');
    }
  }

  Future<void> loadData() async {
    try {
      // Implementasi untuk memuat data dari server
      final response = await http.get('http://127.0.0.1:8000/progress_literasi/set_target_flutter/' as Uri);

      if (response.statusCode == 200) {
        // Parsing data dari response JSON
        final Map<String, dynamic> data = json.decode(response.body);

        // Mendapatkan nilai target dari data JSON
        final int newTarget = data['dailyTarget'];

        // Memperbarui nilai target harian dan menyimpannya
        setDailyTarget(newTarget);
      } else {
        // Handle kesalahan dari server
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle kesalahan koneksi atau lainnya
      print('Error: $error');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('$baseUrl$readingHistoryUrl'),
      headers: {"Content-Type": "application/json"},
    );

    // if (response.statusCode == 200) {
    //   final List<dynamic> data = jsonDecode(response.body);
    //   setState(() {
    //     bookList = data.map((json) => Book.fromJson(json)).toList();
    //   });
    // } else {
    //   throw Exception('Failed to load data');
    // }
  }
}
