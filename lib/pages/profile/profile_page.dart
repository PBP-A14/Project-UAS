import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/pages/authentication/login_page.dart';
import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/pages/profile/profile_detail_page.dart';
import 'package:elibrary/utils/base_url.dart';
import 'package:elibrary/widgets/book_tile.dart';
import 'package:elibrary/widgets/password_form.dart';
import 'package:flutter/material.dart';
import '../../../auth/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<List<Book>> fetchProduct(BuildContext context) async {
    final request = context.watch<CookieRequest>();
    var url = '${baseUrl}my_profile/get_reading_history_json/';
    var response = await request.get(url);
    // print(response);
    var data = [...response];
    // print(data.runtimeType);

    List<Book> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Book.fromJson(d));
      }
    }
    // print(list_product);
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    String uname = CurrUserData.username!;
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello, $uname'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: fetchProduct(context),
                builder: (context, AsyncSnapshot<List<Book>> snapshot) {
                  // print(snapshot.data);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.isEmpty ||
                      snapshot.data == null) {
                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            "Tidak ada riwayat bacaan.",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                          // TextProgressWidget(),
                          // TargetBukuWidget(),
                          // WaktuAktifWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileDetail())),
                                  child: Text('View Details')),
                              ElevatedButton(
                                onPressed: () async {
                                  final response = await request.logout(
                                      "${baseUrl}authentication/mobile-logout/");
                                  String message = response["message"];
                                  if (response['status']) {
                                    String uname = response["username"];
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "$message Sampai jumpa, $uname."),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("$message"),
                                    ));
                                  }
                                }, // Implement your logout functionality here
                                child: Text('Logout',
                                    style: TextStyle(color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .red, // Change to your desired red color
                                ),
                              ),
                              // ElevatedButton(
                              //     onPressed: () => Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => const ProfileDetail())),
                              //     child: Text('View Details')),
                            ],
                          )
                        ]));
                  } else {
                    return Column(
                      children: [
                        Text(
                          'Your Reading History',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length > 5
                              ? 5
                              : snapshot.data!.length,
                          itemBuilder: (context, index) =>
                              BookTile(book: snapshot.data![index]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // ElevatedButton(
                            //     onPressed: () => Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const PasswordFormPage())),
                            //     child: Text('Change Password')),
                            ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileDetail())),
                                child: Text('View Details')),
                            ElevatedButton(
                              onPressed: () async {
                                final response = await request.logout(
                                    "${baseUrl}authentication/mobile-logout/");
                                String message = response["message"];
                                if (response['status']) {
                                  String uname = response["username"];
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content:
                                        Text("$message Sampai jumpa, $uname."),
                                  ));
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("$message"),
                                  ));
                                }
                              }, // Implement your logout functionality here
                              child: Text('Logout',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors
                                    .red, // Change to your desired red color
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
