import 'dart:async';

class TimeStream {
  StreamController timeController = StreamController<DateTime>();
  void timeStream() {
    Timer.periodic(Duration(seconds: 1), (_) {
      timeController.add(DateTime.now());
    });
  }

  void closeStream() {
    timeController.close();
  }
}
