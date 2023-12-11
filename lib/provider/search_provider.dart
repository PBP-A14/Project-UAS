import 'package:flutter/foundation.dart';
import 'package:elibrary/data/api/home_api_service.dart';
import '../utils/enum_resultstate.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String? _lastQuery;

  SearchProvider({required this.apiService}) {
    _state = ResultState.start;
  }

  late ResultState _state;

  ResultState get state => _state;

  late dynamic _bookResult;

  dynamic get result => _bookResult;

  Future<void> fetchBookWithQuery(query) async {
    _lastQuery = query;
    try {
      _state = ResultState.loading;
      notifyListeners();
      List bookList = await apiService.searchBook(query);
      if (bookList.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _bookResult = bookList;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
    }
  }

  void reset() {
    _state = ResultState.start;
    _bookResult = null;
    if (hasListeners) {
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    reset();
    if (_lastQuery != null) {
      fetchBookWithQuery(_lastQuery!);
    }
  }
}
