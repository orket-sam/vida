import 'dart:async';

class TimeStream {
  late final StreamController<DateTime> _timeController;

  TimeStream() {
    _timeController = StreamController();
  }

  Stream get timeStream => _timeController.stream;

  void addTimeToStream() {
    Timer.periodic(Duration(seconds: 1), (_) {
      _timeController.add(DateTime.now());
    });
  }
}
