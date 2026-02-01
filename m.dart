void main() {
  var a = DateTime(
    DateTime.now().year + 1,
  ).difference(DateTime(DateTime.now().year)).inDays;
  print(a.toString());
}
