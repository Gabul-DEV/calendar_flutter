import 'package:calendar_calendar/src/models/day.dart';
import 'package:calendar_calendar/src/service.dart';

class Controller {
  final _service = Service();
  final int month;
  final int year;

  List<List<Day>> list;

  Controller({this.month, this.year}) {
    generate();
  }

  void generate() {
    list = _service.getDaysInMonth(month: month, year: year);
  }
}
