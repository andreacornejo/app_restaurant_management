import 'package:intl/intl.dart';

class StatusTime {
  static String parse(DateTime date) {
    final dateFormat1 = DateFormat("dd MMM", 'es_ES');
    final dateFormat2 = DateFormat("dd MMM yyyy", 'es_ES');
    var hours = DateTime.now().difference(date).inHours;
    if (hours < 1) {
      var min = DateTime.now().difference(date).inMinutes;
      if (min < 1) {
        return 'Hace un momento';
      } else {
        return 'Hace ${min.toString()} min';
      }
    } else if (hours >= 1 && hours <= 24) {
      return 'Hace ${hours.toString()} h';
    } else {
      var dayDifference = DateTime.now().difference(date).inDays;
      if (dayDifference < 6) {
        return 'Hace ${dayDifference.toString()} d';
      }
      var yearNow = DateTime.now().year;
      var year = date.year;
      if (year == yearNow) {
        return dateFormat1.format(date);
      } else {
        return dateFormat2.format(date);
      }
    }
  }
}
