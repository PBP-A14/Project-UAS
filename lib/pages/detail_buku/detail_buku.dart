import 'dart:convert';

import 'package:elibrary/auth/auth.dart';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/pages/detail_buku/add_review.dart';
import 'package:elibrary/pages/detail_buku/give_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBukuPage extends StatefulWidget {
  final Book book;

  DetailBukuPage({required this.book});

  @override
  _DetailBukuPageState createState() => _DetailBukuPageState();
}

class _DetailBukuPageState extends State<DetailBukuPage> {
  double rating = 0.0;
  int likesCount = 0;
  int viewsCount = 0;
  List<Map<String, dynamic>> reviews = [];

  Future<void> fetchData(int bookId) async {
    try {
      final request = Provider.of<CookieRequest>(context, listen: false);

      final response = await request.get(
        'http://127.0.0.1:8000/detail_buku/book/$bookId/book_detail_json/',
      );

      print('Raw Response: $response');

      if (response is Map || response is String) {
        // Handle the case where the response is a Map or a JSON-formatted string
        final responseData = response is String ? jsonDecode(response) : response;
        
        if (responseData is Map) {
          // Handle the successful response
          print('Likes Count: ${responseData['likes_count']}');
          print('Views Count: ${responseData['views_count']}');
          print('Reviews: ${responseData['reviews']}');

          setState(() {
            likesCount = responseData['likes_count'];
            viewsCount = responseData['views_count'];
            reviews = List<Map<String, dynamic>>.from(responseData['reviews']);
          });
        } else {
          // Handle the case where the response is not in the expected format
          throw Exception('Invalid response format');
        }
      } else {
        // Handle the case where the response is not recognized
        throw Exception('Invalid response type');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<Map<String, dynamic>> likeBook(int bookId) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    final response = await request.postJson(
      'http://127.0.0.1:8000/detail_buku/book/$bookId/like_button_flutter/',
      jsonEncode({'csrfmiddlewaretoken': 'your_csrf_token_here'}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to like book');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.book.pk);
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    print('Current viewsCount: $viewsCount');

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Detail'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://covers.openlibrary.org/b/isbn/${widget.book.fields.isbn}-L.jpg',
                  width: 200.0,
                  height: 200.0,
                ),
                SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.book.fields.title,
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.book.fields.description),
                      Text('Authors: ${widget.book.fields.authors}'),
                      Text('ISBN: ${widget.book.fields.isbn}'),
                      Text('Number of Pages: ${widget.book.fields.numPages}'),
                      Text('Publisher: ${widget.book.fields.publisher}'),
                      Text('Rating: ${widget.book.fields.rating.toStringAsFixed(1)}'),
                      Text('Views: $viewsCount'),
                      Text('Likes: $likesCount'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: Text('Like'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (isLiked) return Colors.green;
                              return Colors.blue; 
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Reviews', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final reviewItem = reviews[index];
                final reviewText = reviewItem['review'] as String?;

                if (reviewText != null) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300.0), // Set maximum width
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        reviewText,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                } else {
                  // Handle the case where review is null or not a string
                  return Container();
                }
              },
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle add review button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddReviewPage(
                        bookId: widget.book.pk,
                        onReviewAdded: (updatedReviews) {
                          setState(() {
                            reviews = updatedReviews;
                          });
                        },
                      )),
                    );
                  },
                  child: Text('Add Review'),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    // Handle give rating button press
                    final updatedRating = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GiveRatingPage(book: widget.book)),
                    );

                    // Update the rating if it's not null (user didn't cancel)
                    if (updatedRating != null) {
                      setState(() {
                        widget.book.fields.ratingCount++;
                        widget.book.fields.rating = newRating(updatedRating);
                      });
                    }
                  },
                  child: Text('Give Rating'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double newRating(double input) {
    return (widget.book.fields.rating * widget.book.fields.ratingCount + input) / (widget.book.fields.ratingCount + 1);
  }
}
