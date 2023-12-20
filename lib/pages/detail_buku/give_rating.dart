import 'dart:convert';

import 'package:elibrary/auth/auth.dart';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class GiveRatingPage extends StatefulWidget {
  final Book book;

  GiveRatingPage({required this.book});

  @override
  _GiveRatingPageState createState() => _GiveRatingPageState();
}

class _GiveRatingPageState extends State<GiveRatingPage> {
  TextEditingController ratingController = TextEditingController();

  Future<void> submitRating() async {
    final String ratingString = ratingController.text.trim();
    final double rating = double.tryParse(ratingString) ?? 0.0;

    if (rating < 1 || rating > 5) {
      // Validate the rating
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter a valid rating between 1 and 5.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final request = Provider.of<CookieRequest>(context, listen: false);

    final response = await request.postJson(
      'http://127.0.0.1:8000/detail_buku/book/${widget.book.pk}/give_rating_flutter/',
      jsonEncode({'rating': rating.toString()}),
    );

    // Assuming postJson returns a Map
    if (response['success'] != null) {
      // Handle success
      print('Rating added successfully');
      Navigator.pop(context, rating); // Close the current screen
    } else {
      // Handle other cases
      print('Failed to submit rating. Please try again.');
    }

    if (response is http.Response) {
      print('Status code: ${response.statusCode}');
    } else if (response is Map) {
      print('JSON response: ${response.toString()}');
    } else {
      print('The response is not an http.Response object or a Map');
    }

    if (response.statusCode == 200) {
      // Update UI or navigate to a different page if needed
      print('Rating added successfully');
    } else {
      // Handle error
      print('Failed to submit rating. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Give Rating'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Give Rating',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: ratingController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Rating (1-5)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await submitRating();
                Navigator.pop(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
