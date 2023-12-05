import 'package:flutter/material.dart';
import 'package:elibrary/data/api/progress_api_service.dart'; // Sesuaikan dengan path yang benar


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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressLiterasiBody(),
          ],
        ),
      ),
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
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Your Progress',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
          ),
          TargetBukuWidget(),
          WaktuAktifWidget(),
          ReadingHistoryWidget(),
        ],
      ),
    );
  }
}

class TargetBukuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement Target Baca Harian Widget
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        'Target Baca Harian',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class WaktuAktifWidget extends StatelessWidget {

  final ProgressApiService apiService = ProgressApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: apiService.getActiveTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Ketika sedang loading data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Ketika terjadi error
          return Text('Error: ${snapshot.error}');
        } else {
          // Ketika data sudah tersedia
          final waktuAktif = snapshot.data ?? 'N/A'; // Default jika data null
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Waktu Aktif: $waktuAktif',
              style: const TextStyle(fontSize: 18),
            ),
          );
        }
      },
    );
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
