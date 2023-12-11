import 'package:elibrary/pages/home/book_list_page.dart';
import 'package:elibrary/pages/home/search_page.dart';
import 'package:elibrary/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/enum_resultstate.dart';
import '../../widgets/book_card.dart';
import '../../widgets/book_tile.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

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
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Hero(
              tag: 'searchbar',
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search',
                        ),
                        readOnly: true,
                        onTap: () {
                          Navigator.pushNamed(context, SearchPage.routeName);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          Consumer<HomeProvider>(
            builder: (context, data, _) {
              if (data.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (data.state == ResultState.noData) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Something went wrong',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text('Please contact admin',
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              } else if (data.state == ResultState.error) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.wifi_off,
                            size: 40,
                          ),
                        ),
                        Text(
                          'Oops!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Text(
                            'It seems you are not connected with internet\n'
                                'Check your internet and try again',
                            textAlign: TextAlign.center),
                        TextButton(
                          onPressed: () {
                            Provider.of<HomeProvider>(context,
                                listen: false)
                                .refresh();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return HomeBody(data: data);
              }
            },
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  final HomeProvider data;

  const HomeBody({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'You May Like',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.randomBook.length,
                      shrinkWrap: true,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        var book = data.randomBook[index];
                        return BookCard(
                          book: book,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 12);
                      },
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Our Collections',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        BookListPage.routeName,
                      );
                    },
                    child: const Text('View all'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  var book = data.result[index];
                  return BookTile(
                    book: book,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
