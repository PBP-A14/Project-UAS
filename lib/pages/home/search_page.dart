import 'package:elibrary/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/enum_resultstate.dart';
import '../../widgets/book_card.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  bool _hasInput = false;
  String fields = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _hasInput = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Provider.of<SearchProvider>(context, listen: false).reset();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                Provider.of<SearchProvider>(context, listen: false).reset();
                Navigator.pop(context);
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
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              suffixIcon: _hasInput
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _controller.clear();
                                        // fields = _controller.text;
                                      },
                                    )
                                  : null,
                            ),
                            autofocus: true,
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
                              onPressed: () {
                                setState(() {
                                  fields = _controller.text;
                                  _hasInput = fields.isNotEmpty;
                                });
                                if (_hasInput) {
                                  Provider.of<SearchProvider>(context,
                                          listen: false)
                                      .fetchBookWithQuery(fields);
                                }
                              },
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
              const Divider(),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (context, data, _) {
                    if (data.state == ResultState.start) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.search, size: 40),
                            ),
                            Text(
                              'Enter keyword to search',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    } else if (data.state == ResultState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (data.state == ResultState.noData) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No book found',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text('Try different keyword',
                                textAlign: TextAlign.center),
                          ],
                        ),
                      );
                    } else if (data.state == ResultState.error) {
                      return Center(
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
                                Provider.of<SearchProvider>(context,
                                        listen: false)
                                    .refresh();
                              },
                              child: const Text('Try again'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Result for "$fields"',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.2,
                              shrinkWrap: true,
                              children:
                                  List.generate(data.result.length, (index) {
                                var book = data.result[index].fields;
                                return BookCard(
                                  book: book,
                                );
                              }),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
