import 'dart:async';

class TimeStream {
  final StreamController<DateTime> _controller;
  TimeStream() : _controller = StreamController();
  Stream<DateTime> get stream => _controller.stream;

  void addTimeToStream() {
    Timer.periodic(Duration(seconds: 1), (_) => DateTime.now());
  }

  List<DateTime> currentWeek() {
    List<DateTime> weekDates = [];

    DateTime lastDate = DateTime.now().add(Duration(days: 3));

    for (var i = 0; i < 7; i++) {
      weekDates.add(lastDate.subtract(Duration(days: i)));
    }
    return weekDates.reversed.toList();
  }
}

List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];
