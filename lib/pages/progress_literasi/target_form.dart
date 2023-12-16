import 'dart:convert';

import 'package:elibrary/pages/progress_literasi/progress_literasi_page.dart';
import 'package:flutter/material.dart';
import 'package:elibrary/auth/auth.dart';
import 'package:provider/provider.dart';

class TargetFormPage extends StatefulWidget {
  const TargetFormPage({super.key});

  @override
  State<TargetFormPage> createState() => _TargetFormPage();
}

class _TargetFormPage extends State<TargetFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _target = 0;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Target Buku',
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Target Buku",
                      labelText: "Target Buku",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // TODO: done Tambahkan variabel yang sesuai
                    onChanged: (String? value) {
                      setState(() {
                        try {
                        _target = int.parse(value!);
                        } catch (e) {
                          print('Error parsing value: $value');
                        }
                        });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Target Buku tidak boleh kosong!";
                      }
                      if (int.tryParse(value) == null) {
                        return "Target Buku harus berupa angka!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                      onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                              // Kirim ke Django dan tunggu respons
                              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                              final response = await request.postJson(
                              "http://127.0.0.1:8000/progress_literasi/set_target_flutter/",
                              jsonEncode(<String, String>{
                                  'Target Buku': _target.toString(),
                              }), int: null);
                              
                              print(response);
                              if (response['status'] == 'success') {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                  content: Text("Target baru berhasil disimpan!"),
                                  ));
                                  Navigator.pop(
                                      context,
                                      MaterialPageRoute(builder: (context) => ProgressLiterasiPage()),
                                  );
                              } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                      content:
                                          Text("Terdapat kesalahan, silakan coba lagi."),
                                  ));
                              }
                          }
                      },
                      child: const Text(
                        "Save",
                      ),
                    ),
                  ),
                ),
            ]
          ),
        ),
      ),
    );
  }
}