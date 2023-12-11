import 'dart:async';
import 'dart:convert';
import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/provider/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

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
      body: SingleChildScrollView(
        child: ProgressLiterasiBody(),
      ),
    );
  }
}

class ProgressLiterasiBody extends StatelessWidget {
  const ProgressLiterasiBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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

  Future<void> _submitForm(BuildContext context) async {
    Map<String, dynamic> data = {
      'target_buku': _targetBukuController.text,
    };

    try {
      final cookieRequest = context.read<CookieRequest>();
      var response = await cookieRequest.postJson(
        'http://127.0.0.1:8000/progress_literasi/set_target_flutter/',
        jsonEncode(data),
      );

      print(response);

      if (response['status'] == 'success') {
        print('Target berhasil diatur');
        // Tampilkan target setelah berhasil disimpan
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

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
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

class ReadingHistoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement Riwayat Buku Widget
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Riwayat Buku',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
