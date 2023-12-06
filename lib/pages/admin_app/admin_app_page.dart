import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:elibrary/data/model/user.dart';

class AdminAppPage extends StatefulWidget {
  const AdminAppPage({Key? key}) : super(key: key);

  @override
  _AdminAppPageState createState() => _AdminAppPageState();
}

class _AdminAppPageState extends State<AdminAppPage> {
  Future<List<User>> fetchUser() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/admin_app/user_json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object User
    List<User> list_user = [];
    for (var d in data) {
      if (d != null) {
        list_user.add(User.fromJson(d));
      }
    }
    return list_user;
  }


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
                child: Text('eLibrary'),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () {
                      // Respond to button press
                    },
                    icon: Icon(Icons.add, size: 18),
                    label: Text("Add Book"),
                  ),
                  Container(height: 10),
                  Text(
                    'Users',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ]
            ),
            Expanded(
              child: FutureBuilder(
                  future: fetchUser(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return const Column(
                          children: [
                            Text(
                              "Tidak ada data User.",
                              style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Card(
                            // Define the shape of the card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            // Define how the card's content should be clipped
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            // Define the child widget of the card
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Add padding around the row widget
                                Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              snapshot.data![index].fields.isStaff  ?
                                              Icon(Icons.star_border_outlined, size: 100) : Icon(Icons.account_circle_outlined, size: 100),
                                              Container(width: 20),
                                              // Add an expanded widget to take up the remaining horizontal space
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    // Add some spacing between the top of the card and the title
                                                    Container(height: 5),
                                                    // Add a title widget
                                                    Text(
                                                      "${snapshot.data![index].fields.username}",
                                                      style: TextStyle(color: Colors.black.withOpacity(1.0)),
                                                    ),
                                                    Container(height: 10),
                                                    Text(
                                                      snapshot.data![index].fields.isStaff  ?
                                                      "Role: Admin" : "Role: User",
                                                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                                                    ),
                                                    // Add some spacing between the subtitle and the text
                                                    Container(height: 10),
                                                    // Add a text widget to display some text
                                                    Text(
                                                      "Date Joined: ${snapshot.data![index].fields.dateJoined.toString().substring(0,10)}",
                                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                                    ),
                                                    Container(height: 10),
                                                    // Add a text widget to display some text
                                                    Text(
                                                      snapshot.data![index].fields.lastLogin == null ?
                                                      "Last Login: Never"
                                                          :
                                                      "Last Login: ${snapshot.data![index].fields.lastLogin.toString().substring(0,10)}",
                                                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]
                                    )
                                ),
                              ],
                            ),
                          ),);
                      }
                    }
                  })
            )
          ]
        ));
  }
}
