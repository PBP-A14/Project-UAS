import 'package:flutter/foundation.dart';
import 'package:elibrary/data/api/home_api_service.dart';
import '../utils/enum_resultstate.dart';

class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService}) {
    fetchBook();
  }

  late ResultState _state;

  ResultState get state => _state;

  late dynamic _bookResult;

  dynamic get result => _bookResult;

  late dynamic _randomBook;

  dynamic get randomBook => _randomBook;

  Future<void> fetchBook() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List bookList = await apiService.getBook();
      if (bookList.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _bookResult = bookList;
        _randomBook = getRandomBook();
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  List<T> pickRandomItemsAsList<T>(List<T> items, int count) {
    return (items.toList()..shuffle()).take(count).toList();
  }

  dynamic getRandomBook() {
    return pickRandomItemsAsList(_bookResult, 5);
  }

  Future<void> refresh() async {
    fetchBook();
    notifyListeners();
  }
}
