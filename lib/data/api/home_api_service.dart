import 'dart:convert';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = '10.0.2.2:8000/';
  static const jsonUrl = 'json/';
  static const searchUrl = 'search/';

  Future<List<Book>> getBook() async {
    var url = Uri.parse(
        'http://$baseUrl$jsonUrl');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<Book> bookList = [];
      for (var d in data) {
        if (d != null) {
          bookList.add(Book.fromJson(d));
        }
      }
      return bookList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Book>> searchBook(query) async {
    var url = Uri.parse(
        'http://$baseUrl$searchUrl$query/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List<Book> bookList = [];
      for (var d in data) {
        if (d != null) {
          bookList.add(Book.fromJson(d));
        }
      }
      return bookList;
    } else {
      throw Exception('Failed to load data');
    }
  }
}