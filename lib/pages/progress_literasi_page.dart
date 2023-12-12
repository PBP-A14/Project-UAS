import 'dart:async';
import 'dart:convert';
// import 'package:elibrary/data/model/home_book_model.dart';
// import 'package:elibrary/provider/progress_provider.dart';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/data/model/target_harian_model.dart';
import 'package:elibrary/widgets/book_tile.dart';
import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:elibrary/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart' as http;
class ProgressLiterasiPage extends StatelessWidget {
  const ProgressLiterasiPage({Key? key}) : super(key: key);

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

class ProgressLiterasiBody extends StatelessWidget {
  const ProgressLiterasiBody({Key? key}) : super(key: key);

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
          TargetBukuForm(),
          WaktuAktifWidget(),
          ReadingHistoryWidget(),
        ],
      ),
    );
  }
}

class TargetBukuForm extends StatefulWidget {
  @override
  _TargetBukuFormState createState() => _TargetBukuFormState();
}

class _TargetBukuFormState extends State<TargetBukuForm> {
  final TextEditingController _targetBukuController = TextEditingController();
  bool _showTarget = false;

  Future<List<TargetHarian>> fetchTarget() async {
    var url = Uri.parse('http://127.0.0.1:8000/progress_literasi/show_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<TargetHarian> target_buku = [];
    for (var d in data) {
      if (d != null) {
        target_buku.add(TargetHarian.fromJson(d));
      }
    }
    return target_buku;
  }

  Future<void> _submitForm(BuildContext context) async {
    Map<String, dynamic> data = {
      'target_buku': _targetBukuController.text,
    };

    try {
      final cookieRequest = context.watch<CookieRequest>();
      var response = await cookieRequest.postJson(
        'http://127.0.0.1:8000/progress_literasi/set_target_flutter/',
        jsonEncode(data),
      );

      if (response['status'] == 'success') {
        print('Target berhasil diatur');
        setState(() {
          _showTarget = true;
        });
      } else {
        print('Gagal mengatur target');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _updateTarget(BuildContext context) async {
    Map<String, dynamic> data = {
      'target_buku': _targetBukuController.text,
      'update_target': '1',
    };

    try {
      final cookieRequest = context.watch<CookieRequest>();
      var response = await cookieRequest.postJson(
        'http://127.0.0.1:8000/progress_literasi/update_target/',
        jsonEncode(data),
      );

      if (response['status'] == 'success') {
        print('Target berhasil diperbarui');
        setState(() {
          _showTarget = true;
        });
      } else {
        print('Gagal memperbarui target');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _resetTarget(BuildContext context) async {
    try {
      final cookieRequest = context.watch<CookieRequest>();
      var response = await cookieRequest.postJson(
        'http://127.0.0.1:8000/progress_literasi/reset_target/',
        jsonEncode({}),
      );

      if (response['success']) {
        print('Target berhasil direset');
        setState(() {
          _showTarget = false;
          _targetBukuController.text = ''; // Clear the text field
        });
      } else {
        print('Gagal mereset target');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTarget(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!snapshot.hasData) {
            return const Column(
              children: [
                Text(
                  "Tidak ada data target.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _showTarget
                      ? Text(
                          'Target Harian Anda: ${_targetBukuController.text}',
                          style: TextStyle(fontSize: 18),
                        )
                      : Container(),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _targetBukuController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Target Buku Harian',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm(context);
                    },
                    child: Text('Set Target'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _updateTarget(context);
                    },
                    child: Text('Update Target'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _resetTarget(context);
                    },
                    child: Text('Reset Target'),
                  ),
                ],
              ),
            );
          }
        }
      },
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
