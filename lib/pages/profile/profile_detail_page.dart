import 'package:elibrary/data/model/home_book_model.dart';
import 'package:elibrary/pages/authentication/login_page.dart';
import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/pages/progress_literasi/progress_literasi_page.dart';
import 'package:elibrary/widgets/book_tile.dart';
import 'package:elibrary/widgets/password_form.dart';
import 'package:flutter/material.dart';
import 'package:elibrary/navigation_menu.dart';
import 'package:elibrary/pages/authentication/login_user.dart';
import 'package:elibrary/pages/authentication/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../auth/auth.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});
  @override
  Widget build(BuildContext context) {
    String username = CurrUserData.username!;
    final request = context.watch<CookieRequest>();
    Future<List<Book>> fetchProduct(BuildContext context) async {
      var url = 'http://127.0.0.1:8000/my_profile/get_reading_history_json/';
      var res = await request.get(url);
      var data = [...res];

      List<Book> list_product = [];
      for (var d in data) {
        if (d != null) {
          list_product.add(Book.fromJson(d));
        }
      }
      return list_product;
    }

    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          // IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
          Text('Hi, $username'),
        ],
      ) // Replace $username with your actual username variable
          ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Large icon
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.account_circle_outlined,
                size: 200.0, // Adjust size as needed
                color: Colors.grey, // Adjust color as needed
              ),
            ),
            // Username text
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Text(
                'Username: $username',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextProgressWidget(),
                TargetBukuWidget(),
                WaktuAktifWidget(),
              ],
            ),
            SingleChildScrollView(
                child: FutureBuilder(
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
                        "Tidak ada data produk.",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      // ElevatedButton(
                      //     onPressed: () => Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const PasswordFormPage())),
                      //     child: Text('Change Password')),
                    ],
                  ));
                } else {
                  return Column(
                    children: [
                      Text(
                        'Your Reading History',
                        style: TextStyle(color: Colors.black26, fontSize: 20),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) =>
                            BookTile(book: snapshot.data![index]),
                      ),
                    ],
                  );
                }
              },
            )),

            // Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Change password button
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PasswordFormPage()),
                  ), // Implement your change password functionality here
                  child: Text('Change Password'),
                ),
                // Logout button
                ElevatedButton(
                  onPressed: () async {
                    final response = await request.logout(
                        "http://127.0.0.1:8000/authentication/mobile-logout/");
                    String message = response["message"];
                    if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message Sampai jumpa, $uname."),
                      ));
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message"),
                      ));
                    }
                  }, // Implement your logout functionality here
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Change to your desired red color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
