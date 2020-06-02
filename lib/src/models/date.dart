import '../utils.dart';

class Date {
  final int month;
  final int year;
  final int day;

  Date({this.day, this.month, this.year});

  String get key => "$month/$year";

  @override
  int get hashCode => month * year * day * 2;

  @override
  operator ==(other) => other.hashCode == hashCode;

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
