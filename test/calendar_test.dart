// testWidgets('Test Calendar', (tester) async {
//     var date = DateTime.now();
//     var year = date.year;
//     var month = date.month;
//     var weekDay = date.weekday;
//     var leapYear = false;

//     var maxDays = DateUtil().daysInMonth(date.month, date.year);
//     var list = List.generate(maxDays, (index) => "${index + 1}");
//     var daysList = list.map(int.parse).toList();

//     await tester.pumpWidget(MaterialApp(
//       home: RaroCalendar.render(behaviour: Behaviour.regular),
//     ));

//     /// days - 1 to 31
//     for (var i = 1; i <= daysList.length; i++) {
//       expect(daysList[i - 1], i);
//     }

//     /// leap year
//     if ((year % 100 != 0) && (year % 4 == 0) || year % 400 == 0) {
//       for (var i = year; i <= 2400; i += 4) {
//         expect(year, i);
//         year += 4;
//         leapYear = true;
//       }
//     }

//     // days in the specific month
//     if (month > 0 && month <= 7) {
//       if (month % 2 != 0) {
//         expect(maxDays, 31);
//       } else if (month % 2 == 0 && month != 2) {
//         expect(maxDays - 1, 30);
//       } else if (leapYear == true && month == 2) {
//         print(maxDays - 2);
//         expect(maxDays - 2, 29);
//       } else {
//         expect(maxDays - 3, 28);
//       }
//     } else if (month > 7 && month <= 12) {
//       if (month % 2 == 0) {
//         expect(maxDays, 31);
//       } else {
//         expect(maxDays - 1, 30);
//       }
//     } else {
//       expect(month, month + 1);
//     }

//     /// weekday
//     if (weekDay > 0 && weekDay <= 7) {
//       for (var i = weekDay; i <= 7; i++) {
//         expect(weekDay, i);
//         weekDay++;
//       }
//     } else {
//       /// se nao for o dia da semana acima, retorna erro
//       expect(weekDay, weekDay + 1);
//     }

//     /// month - 1 to 12
//     if (month > 0 && month <= 12) {
//       for (var i = month; i <= 12; i++) {
//         expect(month, i);
//         month++;
//       }
//     } else {
//       // se for 0 ou maior que treze retorna erro
//       expect(month, month + 1);
//     }

//     /// year - 1900 to 2999
//     if (year >= 1900 && year <= 2999) {
//       for (var i = year; i <= 2999; i++) {
//         expect(year, i);
//         year++;
//       }
//     } else {
//       /// se nao for o ano acima, retorna erro
//       expect(year, year + 1);
//     }
//   });
