// List<String> _months = [
//   "January",
//   "Febuary",
//   "March",
//   "April",
//   "May",
//   "June",
//   "July",
//   "August",
//   "September",
//   "October",
//   "November",
//   "December",
// ];

// converts timesampt to date in format dd/mm/yyyy
String timestampToDate(double timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp.toInt());
  String d = date.toString();
  return "${d.substring(8, 10)}-${d.substring(5, 7)}-${d.substring(0, 4)}";
}

// figures out how long since the timestamp
String timeSinceTimestamp(double timestamp) {
  return "7";
}
