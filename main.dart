void main() {
  print(currentWeek());
}

List<DateTime> currentWeek() {
  List<DateTime> weekDates = [];

  DateTime lastDate = DateTime.now().add(Duration(days: 3));

  for (var i = 0; i < 7; i++) {
    weekDates.add(lastDate.subtract(Duration(days: i)));
    print(lastDate.subtract(Duration(days: i)).weekday);
    print(lastDate.subtract(Duration(days: i)).day);
  }
  return weekDates.reversed.toList();
}
