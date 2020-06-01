import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import 'utils.dart';

enum PageDirection { previous, next, none }

class Date {
  final int month;
  final int year;
  final int day;

  Date({this.day, this.month, this.year});

  String get key => "$month/$year";

  @override
  String toString() => "$day de ${month.month}, $year";

  factory Date.addMonth(Date current) {
    if (current.month + 1 == 13) {
      final year = current.year + 1;
      final month = 1;
      return Date(month: month, year: year);
    } else {
      final month = current.month + 1;
      return Date(month: month, year: current.year);
    }
  }

  factory Date.removeMonth(Date current) {
    if (current.month - 1 == 0) {
      final year = current.year - 1;
      final month = 12;
      return Date(month: month, year: year);
    } else {
      final month = current.month - 1;
      return Date(month: month, year: current.year);
    }
  }
}

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

  factory DataCollection.init() {
    final now = DateTime.now();
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

  CalendarPageController(PageController pageController) {
    dataCollection = DataCollection.init();
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
