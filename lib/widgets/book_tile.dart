import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';

class BookTile extends StatelessWidget {
  final Fields book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String newRating;

    if (book.ratingCount == 0) {
      newRating = 'No rating';
    } else {
      newRating = '${book.rating}';
    }

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 125,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  color: Colors.grey,
                  height: 100,
                  width: 100 / 1.4,
                  child: Image.network(
                    'https://covers.openlibrary.org/b/isbn/${book.isbn}-M.jpg',
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, _, __) {
                      return const Center(child: Text('No Image'));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        book.authors,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text('Rating: $newRating'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
