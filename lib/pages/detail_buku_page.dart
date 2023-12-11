import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../data/model/home_book_model.dart';
import 'dart:convert';

class DetailBukuPage extends StatelessWidget {
  final Fields book;

  const DetailBukuPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://covers.openlibrary.org/b/isbn/${book.isbn}-L.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              // Add a little space
              const SizedBox(height: 16.0),

              // Display the book's title
              Text(
                book.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              // Display the book's author
              Text(
                'Author: ${book.authors}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Display the book's review, views and likes count
              // Text(
              //   'Review: ${book.review}, Views: ${book.views}, Likes: ${book.likes}',
              //   style: Theme.of(context).textTheme.subtitle2,
              // ),

              // Display the book's rating
              Text(
                'Rating: ${book.rating}',
                style: Theme.of(context).textTheme.titleSmall,
              ),

              // Display the book's ISBN
              Text(
                'ISBN: ${book.isbn}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Display the book's number of pages
              Text(
                'Number of pages: ${book.numPages}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Display the book's publisher
              Text(
                'Publisher: ${book.publisher}',
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Add a little space
              const SizedBox(height: 16.0),

              // Display the book's synopsis
              Text(
                'Synopsis:${book.description}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              ReviewForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewForm extends StatefulWidget {
  const ReviewForm({super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _review = "";
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _reviewController,
            decoration: const InputDecoration(
              hintText: 'Enter your review',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your review';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _review = _reviewController.text;

                  // Send to server and wait for response
                  final response = await request.postJson(
                    "http://your-server-url/review-endpoint/",
                    jsonEncode(<String, String>{
                      'review': _reviewController.text,
                    }),
                  );
                  if (response['status'] == 'success') {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                        content: Text("Review successfully submitted!"),
                      ));
                  } else {
                    ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(
                        content: Text("There was an error, please try again."),
                      ));
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }
}
