import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../../auth/auth.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Book>> fetchProduct(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    var url = 'http://127.0.0.1:8000/my_profile/get_reading_history_json/';
    var response = await request.get(url);
    // print(response);
    var data = [...response];
    // print(data.runtimeType);

    List<Book> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    // print(list_product);
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    String uname = CurrUserData.username!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${uname}'),
      ),
      body: FutureBuilder(
        future: fetchProduct(context),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          // print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Tidak ada data produk.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  var book = snapshot.data![index];
                  return BookTile(book: book);
                });
          }
        },
      ),
    );
  }
}
