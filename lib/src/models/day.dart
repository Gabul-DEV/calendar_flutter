import 'package:calendar_calendar/calendar_calendar.dart';

class Day {
  final int value;
  final int weekDay;
  final Date date;

  @override
  String toString() => value == 0 ? "" : "$value";

  String get label => value == 0 ? "" : "$value";

  bool get isWeekend => weekDay == 0 || weekDay == 6;

  Day({this.date, this.value, this.weekDay});

  @override
  int get hashCode => date.hashCode;

  operator ==(other) => other.hashCode == hashCode;
}
