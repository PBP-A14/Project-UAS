import 'package:flutter/foundation.dart';
import 'package:elibrary/data/api/home_api_service.dart';
import '../utils/enum_resultstate.dart';


//TODO: buat inisiasi randomBook sekali aja biar gak berat.
//TODO: sama nyimpen book di ourcollections biar ga berubah2
class HomeProvider extends ChangeNotifier {
  final ApiService apiService;

  HomeProvider({required this.apiService}) {
    fetchBook();
    // _randomBook = getRandomBook();
  }

  late ResultState _state;
  ResultState get state => _state;

  late dynamic _bookResult;
  dynamic get result => _bookResult;

  late dynamic _randomBook;
  dynamic get randomBook => _randomBook;

  bool _isAZChecked = false;
  bool _isZAChecked = false;

  bool get isAZChecked => _isAZChecked;
  bool get isZAChecked => _isZAChecked;

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
    resetFilter();
    notifyListeners();
  }

  void toggleAZ(bool value) {
    _isAZChecked = value;
    notifyListeners();
  }

  void toggleZA(bool value) {
    _isZAChecked = value;
    notifyListeners();
  }

  void resetFilter() {
    _isAZChecked = false;
    _isZAChecked = false;
    fetchBook();
    notifyListeners();
  }

  Future<void> setFilterAZ() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List bookList = await apiService.getBookAZ();
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

  Future<void> setFilterZA() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      List bookList = await apiService.getBookZA();
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
}
