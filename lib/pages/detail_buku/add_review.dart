import 'dart:convert';

import 'package:elibrary/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddReviewPage extends StatefulWidget {
  final int bookId;
  final Function(List<Map<String, dynamic>>) onReviewAdded;

  AddReviewPage({required this.bookId, required this.onReviewAdded});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController reviewController = TextEditingController();
  
  get http => null;

  Future<void> submitReview(BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/detail_buku/book/${widget.bookId}/add_review_flutter/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'review': reviewController.text, // Gunakan nama yang benar sesuai dengan formulir Django
        }),
      );

      print('Full Response: $response');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('likes_count') &&
            responseData.containsKey('views_count') &&
            responseData.containsKey('reviews')) {
          int likesCount = responseData['likes_count'];
          int viewsCount = responseData['views_count'];
          final List<Map<String, dynamic>> newReviews =
              List<Map<String, dynamic>>.from(responseData['reviews']);

          // Update your state with the new data
          setState(() {
            likesCount = likesCount;
            viewsCount = viewsCount;
            var reviews = newReviews;
          });

          widget.onReviewAdded(newReviews);
          Navigator.pop(context);
        } else {
          print('Error: "likes_count", "views_count", or "reviews" key not found in response');
        }
      } else {
        print('Error submitting review: ${response.body}');
      }
    } catch (e) {
      print('Error submitting review: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Review',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => submitReview(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
