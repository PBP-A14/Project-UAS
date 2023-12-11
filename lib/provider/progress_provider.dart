
import 'package:elibrary/data/api/progress_api_service.dart';
import 'package:elibrary/utils/enum_resultstate.dart';
import 'package:flutter/material.dart';


class ProgressProvider extends ChangeNotifier {
  final ProgressApiService apiService;
  int? _dailyTarget;
  ResultState _state = ResultState.start;

  ProgressProvider({required this.apiService});

  ResultState get state => _state;
  int? get dailyTarget => _dailyTarget;

  Future<void> setDailyTarget(int target) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      await apiService.setDailyTarget(target);

      _dailyTarget = target;
      _state = ResultState.hasData;
      notifyListeners();
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
    }
  }
}
