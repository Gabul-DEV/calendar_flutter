import 'package:date_util/date_util.dart';

import 'models/day.dart';

class Service {
  int maxDaysInMonth({int month, int year}) =>
      DateUtil().daysInMonth(month, year);

  int weekDayByDate(DateTime date) => date.weekday == 7 ? 0 : date.weekday;

  List<List<Day>> getDaysInMonth({int month, int year}) {
    final date = DateTime(year, month);

    var weekDay = weekDayByDate(date);

    var monthDays = maxDaysInMonth(month: month, year: year);

    var listDays = List.generate(monthDays, (index) => index + 1);

    //Generate spaces start month
    if (weekDay > 0) {
      var listSpace = List.generate(weekDay, (index) => 0);
      listDays = List.from(listSpace + listDays);
    }

    //Generate spaces and month

    final weeks = (listDays.length ~/ 7).toInt();
    final listNumberScape = 7 - (listDays.length - weeks * 7);
    final listSpace = List.generate(listNumberScape, (index) => 0);

    listDays = List.from(listDays + listSpace);

    //Generate Map of Weeks
    final listWeeks = <List<Day>>[];
    var listDaysOfWeek = <Day>[];
    var weekDayCount = 0;

    for (var item in listDays) {
      listDaysOfWeek.add(Day(value: item, weekDay: weekDayCount));
      weekDayCount++;
      if (listDaysOfWeek.length == 7) {
        listWeeks.add(List.from(listDaysOfWeek));
        listDaysOfWeek.clear();

        weekDayCount = 0;
      }
    }
    return listWeeks;
  }
}
