import 'package:elibrary/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String newTitle;
    String newAuthor;

    if (book.fields.title.length > 20) {
      newTitle = '${book.fields.title.substring(0, 20)}...';
    } else {
      newTitle = book.fields.title;
    }

    if (book.fields.authors.length > 20) {
      newAuthor = '${book.fields.authors.substring(0, 20)}...';
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
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 125 * 1.4,
                    width: 125,
                    color: Colors.grey,
                    child: Image.network(
                      'https://covers.openlibrary.org/b/isbn/${book.fields.isbn}-L.jpg',
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, _, __) {
                        return const Center(child: Text('No Image'));
                      },
                    ),
                  ),
                ),
              ),
            ),
            Text(
              newTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(newAuthor, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
