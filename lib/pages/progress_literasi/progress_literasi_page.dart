import 'dart:async';
import 'dart:convert';

import 'package:elibrary/data/model/home_book_model.dart';
// import 'package:elibrary/data/model/target_harian_model.dart';
import 'package:elibrary/pages/progress_literasi/target_form.dart';
import 'package:elibrary/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:elibrary/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

int _target = 0;

class ProgressLiterasiPage extends StatefulWidget {
  const ProgressLiterasiPage({Key? key}) : super(key: key);

  @override
  _ProgressLiterasiPageState createState() => _ProgressLiterasiPageState();
}

class _ProgressLiterasiPageState extends State<ProgressLiterasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/E-Lib.png',
              scale: 24,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Progress Literasi'),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: ProgressLiterasiBody(),
    );
  }
}

class ProgressLiterasiBody extends StatefulWidget {
  const ProgressLiterasiBody({Key? key}) : super(key: key);

  @override
  _ProgressLiterasiBodyState createState() => _ProgressLiterasiBodyState();
}

class _ProgressLiterasiBodyState extends State<ProgressLiterasiBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Your Progress',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          TextProgressWidget(),
          TargetBukuWidget(),
          WaktuAktifWidget(),
          ReadingHistoryWidget(),
        ],
      ),
    );
  }
}

class TextProgressWidget extends StatefulWidget {
  @override
  _TextProgressWidgetState createState() => _TextProgressWidgetState();
}

class _TextProgressWidgetState extends State<TextProgressWidget> {
  String textProgress = '';

  Future<void> getTextProgress() async {
    final request = context.read<CookieRequest>();

    try {
      final response = await request.get(
        'http://127.0.0.1:8000/progress_literasi/get_text_mobile/',
        // Add any necessary headers, like authentication headers, if required
      );

      if (response is Map<String, dynamic>) {
        // Check if the response is a JSON map
        final data = response;
        setState(() {
          textProgress = data['text_progress'];
        });
      } else {
        // Handle unexpected response format
        print('Unexpected response format: $response');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTextProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Your bold text here
        
        // The text progress fetched from Django
        Text(
          '    $textProgress',
          style: TextStyle(fontWeight: FontWeight.bold)),
        // Your other widgets...
      ],
    );
  }
}

class TargetBukuWidget extends StatefulWidget {
  @override
  _TargetBukuWidgetState createState() => _TargetBukuWidgetState();
}

class _TargetBukuWidgetState extends State<TargetBukuWidget> {
  Future<int> fetchTargetValue(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    request.headers = {"Content-Type": "application/json"};
    var response = await request.get(
      'http://127.0.0.1:8000/progress_literasi/show_json/',
    );

    if (response.length > 0) {
      var data = response[0]['fields']['target_buku'];
      return data;
    } else {
      throw Exception('Failed to load target values');
    }
  }

  Future<void> resetTarget(BuildContext context) async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    request.headers = {"Content-Type": "application/json"};

    try {
      var response = await request.postJson(
          'http://127.0.0.1:8000/progress_literasi/reset_mobile/',
          jsonEncode(<String, String>{
            'Target Buku': _target.toString(),
          }),
          int: null // Add an empty map as the request body
          );

      if (response['success']) {
        // Handle success, e.g., show a success message
        print(response['message']);

        // Update the UI with the new target value (0)
        // You may need to adapt this part based on your UI structure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Target berhasil direset.'),
          ),
        );

        // You can also update the UI in other ways based on the new target value
      } else {
        // Handle failure, e.g., show an error message
        print(response['message']);
      }
    } catch (e) {
      // Handle exceptions, e.g., show an error message
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder<int>(
          future: fetchTargetValue(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              var targetData = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('    Target Buku Kamu: ${targetData.toString()} buku'),
                  if (targetData != null && targetData > 0) ...[
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TargetFormPage()),
                            );
                          },
                          child: Text('Update Target'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            resetTarget(context);
                          },
                          child: Text('Reset Target'),
                        )
                      ],
                    )
                  ] else ...[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TargetFormPage()),
                        );
                      },
                      child: Text('Set Target'),
                    )
                  ]
                ],
              );
            }
          },
        ),
      ],
    );
  }
}

class WaktuAktifWidget extends StatefulWidget {
  @override
  _WaktuAktifWidgetState createState() => _WaktuAktifWidgetState();
}

class _WaktuAktifWidgetState extends State<WaktuAktifWidget> {
  late Timer _timer;
  int _elapsedTimeInSeconds = 0;
  late DateTime _loginTimestamp;

  @override
  void initState() {
    super.initState();

    _readLoginTimestamp();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTimeInSeconds++;
      });
    });
  }

  _readLoginTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timestampStr = prefs.getString('loginTimestamp');

    if (timestampStr != null) {
      _loginTimestamp = DateTime.parse(timestampStr);
    } else {
      _loginTimestamp = DateTime.now();
      prefs.setString('loginTimestamp', _loginTimestamp.toIso8601String());
    }
  }

  @override
  Widget build(BuildContext context) {
    int hours = _elapsedTimeInSeconds ~/ 3600;
    int minutes = (_elapsedTimeInSeconds % 3600) ~/ 60;
    int seconds = _elapsedTimeInSeconds % 60;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'Waktu Aktif: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  void dispose() {
    _saveLoginTimestamp();
    _timer.cancel();
    super.dispose();
  }

  _saveLoginTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginTimestamp', _loginTimestamp.toIso8601String());
  }
}

class ReadingHistoryWidget extends StatefulWidget {
  @override
  _ReadingHistoryWidgetState createState() => _ReadingHistoryWidgetState();
}

class _ReadingHistoryWidgetState extends State<ReadingHistoryWidget> {
  Future<List<Book>> fetchProduct(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    var url = 'http://127.0.0.1:8000/my_profile/get_reading_history_json/';
    var response = await request.get(url);
    var data = [...response];

    List<Book> list_product = [];
    for (var d in data) {
      if (d != null) {
        list_product.add(Book.fromJson(d));
      }
    }
    return list_product;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Set a fixed height for ReadingHistoryWidget
      child: FutureBuilder(
        future: fetchProduct(context),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Tidak ada riwayat bacaan.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Riwayat Buku',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      var book = snapshot.data![index];
                      return BookTile(book: book);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
