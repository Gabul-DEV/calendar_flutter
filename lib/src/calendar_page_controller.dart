import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import 'models/date.dart';
import 'utils.dart';

enum PageDirection { previous, next, none }

class DataCollection {
  Date currentMonth;
  Date previousMonth;
  Date nextMonth;

  DataCollection({this.currentMonth, this.previousMonth, this.nextMonth});

  factory DataCollection.next(Date old) {
    final current = Date.addMonth(old);
    return DataCollection.mount(current);
  }

  factory DataCollection.previous(Date old) {
    final current = Date.removeMonth(old);
    return DataCollection.mount(current);
  }

  factory DataCollection.mount(Date current) {
    return DataCollection(
        previousMonth: Date.removeMonth(current),
        currentMonth: current,
        nextMonth: Date.addMonth(current));
  }

  factory DataCollection.init({DateTime initialDate}) {
    final now = initialDate ?? DateTime.now();
    final current = Date(month: now.month, year: now.year);
    return DataCollection(
        previousMonth: Date.removeMonth(current),
        currentMonth: current,
        nextMonth: Date.addMonth(current));
  }
}

class CalendarPageController {
  final currentPage = BehaviorSubject<int>();
  final update = BehaviorSubject<PageDirection>();
  var month;
  var year;
  DataCollection dataCollection;
  StreamSubscription subscription;

  CalendarPageController(PageController pageController, DateTime initialDate) {
    dataCollection = DataCollection.init(initialDate: initialDate);
    update.sink.add(PageDirection.none);

    subscription = currentPage.stream.listen((event) {
      if (event == 0) {
        //Previous Month
        dataCollection = DataCollection.previous(dataCollection.currentMonth);
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          update.sink.add(PageDirection.previous);
          pageController.jumpToPage(1);
        });
      } else if (event == 2) {
        dataCollection = DataCollection.next(dataCollection.currentMonth);
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          update.sink.add(PageDirection.next);
          pageController.jumpToPage(1);
        });
      }
    });
    month = update.stream
        .asyncMap<String>((event) => dataCollection.currentMonth.month.month);
  }

  void onChage(int value) => currentPage.sink.add(value);

  void dispose() {
    subscription.cancel();
    update.close();
    currentPage.close();
  }
}
