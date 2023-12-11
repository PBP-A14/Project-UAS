import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';
import 'bottom_sheet.dart';

class BookTile extends StatelessWidget {
  final Book book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String newRating;
    String newTitle;
    String newAuthor;

    if (book.fields.ratingCount == 0) {
      newRating = 'No rating';
    } else {
      newRating = '${book.fields.rating}';
    }

    if (book.fields.title.length > 50) {
      newTitle = '${book.fields.title.substring(0, 50)}...';
    } else {
      newTitle = book.fields.title;
    }

    if (book.fields.authors.length > 25) {
      newAuthor = '${book.fields.authors.substring(0, 25)}...';
    } else {
      newAuthor = book.fields.authors;
    }

    return InkWell(
      onTap: () {
        showModalBottomSheet<dynamic>(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Wrap(
              children: <Widget>[
                BookBottomSheet(
                  book: book,
                ),
              ],
            );
          },
        );
      },
      child: Material(
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
                      'https://covers.openlibrary.org/b/isbn/${book.fields.isbn}-M.jpg',
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
                          newTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          newAuthor,
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
      ),
    );
  }
}
