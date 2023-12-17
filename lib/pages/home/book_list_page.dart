import 'package:elibrary/pages/home/search_page.dart';
import 'package:elibrary/provider/home_provider.dart';
import 'package:elibrary/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/enum_resultstate.dart';
import '../../widgets/filter_button.dart';

class BookListPage extends StatefulWidget {
  static const routeName = '/book-list';

  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 200) {
        setState(() {
          _showButton = true;
        });
      } else {
        setState(() {
          _showButton = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<HomeProvider>(context, listen: false).resetFilter();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                Navigator.pop(context);
                Provider.of<HomeProvider>(context, listen: false).resetFilter();
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chevron_left),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
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
                              Navigator.pushNamed(
                                  context, SearchPage.routeName);
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
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: SizedBox(child: FilterButton()),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'All Books',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: Consumer<HomeProvider>(
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
                      return Stack(
                        children: <Widget>[
                          GridView.count(
                            controller: _scrollController,
                            crossAxisCount: 2,
                            childAspectRatio: 1 / 1.2,
                            shrinkWrap: true,
                            children:
                                List.generate(data.result.length, (index) {
                              var book = data.result[index];
                              return BookCard(
                                book: book,
                              );
                            }),
                          ),
                          if (_showButton)
                            Positioned(
                              bottom: 10.0,
                              right: 10.0,
                              child: FloatingActionButton(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                child: const Icon(
                                  Icons.arrow_upward),
                                onPressed: () {
                                  _scrollController.animateTo(
                                    0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
