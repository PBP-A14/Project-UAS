import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';

class BookBottomSheet extends StatelessWidget {
  final Fields book;

  const BookBottomSheet({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String newRating;

    if (book.ratingCount == 0) {
      newRating = 'No rating';
    } else {
      newRating = '${book.rating}';
    }

    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        color: Color(0xFFFCFCFC),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              color: Colors.grey,
              height: 2,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 125 * 1.4,
                      width: 125,
                      color: Colors.grey,
                      child: Image.network(
                        'https://covers.openlibrary.org/b/isbn/${book.isbn}-L.jpg',
                        fit: BoxFit.fitWidth,
                      ),
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
                            fontSize: 18,
                          ),
                        ),
                        Text(book.authors),
                        Divider(),
                        Text('Rating: $newRating'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info_outline_rounded),
                label: const Text('Detail'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
