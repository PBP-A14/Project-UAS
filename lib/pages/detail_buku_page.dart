import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';

class DetailBukuPage extends StatelessWidget {
  final Book book;

  const DetailBukuPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.fields.title),
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
                      'https://covers.openlibrary.org/b/isbn/${book.fields.isbn}-L.jpg',
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),

              // Add a little space
              const SizedBox(height: 16.0),

              // Display the book's title
              Text(
                book.fields.title,
                style: Theme.of(context).textTheme.headline5,
              ),

              // Display the book's author
              Text(
                'Author: ${book.fields.authors}',
                style: Theme.of(context).textTheme.subtitle1,
              ),

              // Display the book's review, views and likes count
              // Text(
              //   'Review: ${book.field.review}, Views: ${book.fields.views}, Likes: ${book.fields.likes}',
              //   style: Theme.of(context).textTheme.subtitle2,
              // ),

              // Display the book's rating
              Text(
                'Rating: ${book.fields.rating}',
                style: Theme.of(context).textTheme.subtitle2,
              ),

              // Display the book's ISBN
              Text(
                'ISBN: ${book.fields.isbn}',
                style: Theme.of(context).textTheme.subtitle1,
              ),

              // Display the book's number of pages
              Text(
                'Number of pages: ${book.fields.numPages}',
                style: Theme.of(context).textTheme.subtitle1,
              ),

              // Display the book's publisher
              Text(
                'Publisher: ${book.fields.publisher}',
                style: Theme.of(context).textTheme.subtitle1,
              ),

              // Add a little space
              const SizedBox(height: 16.0),

              // Display the book's synopsis
              Text(
                'Synopsis:${book.fields.description}',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
