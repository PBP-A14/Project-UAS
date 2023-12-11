import 'dart:async';

class TimerProvider {
  late DateTime loginTimestamp;
  late int userId;
  late String timeString;
  late DateTime currentDate;
  late Duration elapsedTime;
  late bool isTimerRunning;

  Timer? timer;

  TimerProvider({required this.userId}) {
    initializeTimer();
  }

  void initializeTimer() {
    loginTimestamp = DateTime.now();
    currentDate = DateTime.now();
    elapsedTime = Duration(seconds: 0);
    isTimerRunning = true;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateActivityTimer();
    });
  }

  void updateActivityTimer() {
    currentDate = DateTime.now();
    elapsedTime = currentDate.difference(loginTimestamp);

    if (elapsedTime.inSeconds >= 18000) {
      // Jika lebih dari 5 jam, reset waktu dari awal
      loginTimestamp = DateTime.now();
      elapsedTime = Duration(seconds: 0);
    }

    int hours = elapsedTime.inHours;
    int minutes = (elapsedTime.inMinutes % 60);
    int seconds = (elapsedTime.inSeconds % 60);

    timeString =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void handleLogout() {
    isTimerRunning = false;
    timer?.cancel();
    loginTimestamp = DateTime.now();
    elapsedTime = Duration(seconds: 0);

    // Handle logout logic
  }

  void dispose() {
    timer?.cancel();
  }
}
