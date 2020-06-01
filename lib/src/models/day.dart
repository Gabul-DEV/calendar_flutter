class Day {
  final int value;
  final int weekDay;

  @override
  String toString() => value == 0 ? "" : "$value";

  String get label => value == 0 ? "" : "$value";

  bool get isWeekend => weekDay == 0 || weekDay == 6;

  Day({this.value, this.weekDay});

  @override
  int get hashCode => value;

  operator ==(other) => other.hashCode == hashCode;
}
