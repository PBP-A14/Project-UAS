import 'dart:convert';

import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/utils/base_url.dart';
import 'package:flutter/material.dart';
import '../data/model/home_book_model.dart';
import 'package:http/http.dart' as http;
import '../pages/detail_buku_page.dart';

class BookBottomSheet extends StatelessWidget {
  final Book book;

  const BookBottomSheet({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    String newRating;

    if (book.fields.ratingCount == 0) {
      newRating = 'No rating';
    } else {
      newRating = '${book.fields.rating}';
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
                        'https://covers.openlibrary.org/b/isbn/${book.fields.isbn}-L.jpg',
                        fit: BoxFit.fitWidth,
                        errorBuilder: (context, _, __) {
                          return const Center(child: Text('No Image'));
                        },
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
                          book.fields.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Text(book.fields.authors),
                        const Divider(),
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
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        Uri url = Uri.parse(
                            "${baseUrl}progress_literasi/read-book-mobile/");
                        final data = jsonEncode({
                          'book_id': book.pk,
                          'user_id': CurrUserData.userId!,
                        });
                        await http.post(url, body: data);
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.black),
                        overlayColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.black.withOpacity(.1);
                          }
                          return Colors.transparent;
                        }),
                      ),
                      child: const Text('Read'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailBukuPage(book: book.fields)),
                        );
                      },
                      icon: const Icon(Icons.info_outline_rounded),
                      label: const Text('Detail'),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.black),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
