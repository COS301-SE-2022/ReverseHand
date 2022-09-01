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
  String time = "minutes";

  int difference =
      ((DateTime.now().millisecondsSinceEpoch - timestamp.toInt()) /
              (1000 * 60))
          .floor(); // getting to minutes

  if ((difference / 60).floor() != 0) {
    difference = (difference / 60).floor(); // hours
    time = "hours";

    if ((difference / 24).floor() != 0) {
      time = "days";
      difference = (difference / 24).floor();
    }
  }

  time = difference == 1 ? time.substring(0, time.length - 1) : time;

  return "$difference $time ago";
}
