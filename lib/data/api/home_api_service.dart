import 'dart:convert';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/base_url.dart';

class ApiService {
  static const jsonUrl = 'json/';
  static const searchUrl = 'search/';
  static const filterAZUrl = 'json/a-z/';
  static const filterZAUrl = 'json/z-a/';

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

  Future<List<Book>> getBookAZ() async {
    var url = Uri.parse(
        'http://$baseUrl$filterAZUrl');
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

  Future<List<Book>> getBookZA() async {
    var url = Uri.parse(
        'http://$baseUrl$filterZAUrl');
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
