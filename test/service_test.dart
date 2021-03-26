import 'package:calendar_calendar/src/service.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late Service service;

  setUp(() {
    service = Service();
  });
  group("Service Test", () {
    test("Max Days in Month - 05/2020", () {
      final max = service.maxDaysInMonth(month: 5, year: 2020);
      expect(max, 31);
    });

    test("Get Week Day - 01/05/2020", () {
      final week = service.weekDayByDate(DateTime(2020, 5, 1));
      expect(week, 5);
    });

    test("Get Days in Moth - 05/2020", () {
      final week = service.getDaysInMonth(month: 5, year: 2020);
      expect(week.length, 6);
    });
  });
}
