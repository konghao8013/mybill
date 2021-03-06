

class DateTimeHelper {
  static getToDayRange() {
    var toDay = DateTime.now();
    var tomorrow = DateTime.now().add(new Duration(days: 1));
    var rel = List<DateTime>();
    rel.add(new DateTime(toDay.year, toDay.month, toDay.day));
    rel.add(new DateTime(tomorrow.year, tomorrow.month, tomorrow.day));
    return rel;
  }

  static getToMonthRange() {
    var toDay = DateTime.now();
    var rel = List<DateTime>();
    rel.add(new DateTime(toDay.year, toDay.month, 1));
    rel.add(new DateTime(toDay.year, toDay.month + 1, 1));
    return rel;
  }
}
