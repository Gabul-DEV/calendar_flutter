import 'package:calendar_calendar/src/calendar_page_controller.dart';
import 'package:calendar_calendar/src/widgets/day_widget.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class CalendarWidget extends StatefulWidget {
  final Date date;
  final Color activeColor;
  final Color backgroundColor;
  final TextStyle selectedStyle;
  final TextStyle textStyleDays;
  final TextStyle textStyleWeekDay;
  final TextStyle titleStyle;
  final ValueChanged<Date> onSelected;
  final PageController pageController;
  final Widget previous;
  final Widget next;
  final bool weekendOpacityEnable;
  final double weekendOpacity;
  const CalendarWidget(
      {Key key,
      this.activeColor,
      this.textStyleDays,
      this.textStyleWeekDay,
      this.onSelected,
      this.backgroundColor,
      @required this.date,
      this.previous,
      this.next,
      this.pageController,
      this.titleStyle,
      this.selectedStyle,
      this.weekendOpacityEnable,
      this.weekendOpacity})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  Controller _controller;
  var daySelected;
  @override
  void initState() {
    _controller = Controller(month: widget.date.month, year: widget.date.year);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Column(
        children: [
          Table(
            children: [
              ..._controller.list
                  .map((week) => TableRow(
                      children: week
                          .map((day) => DayWidget(
                                day: day,
                                isSelected: daySelected == day,
                                style: daySelected == day
                                    ? widget.selectedStyle
                                    : widget.weekendOpacityEnable &&
                                            day.isWeekend
                                        ? widget.textStyleDays.copyWith(
                                            color: widget.textStyleDays.color
                                                .withOpacity(
                                                    widget.weekendOpacity))
                                        : widget.textStyleWeekDay,
                                activeColor: widget.activeColor,
                                backgroundColor: widget.backgroundColor,
                                onTap: () {
                                  widget.onSelected(Date(
                                      day: day.value,
                                      month: widget.date.month,
                                      year: widget.date.year));
                                  if (day == daySelected) {
                                    daySelected = null;
                                  } else {
                                    daySelected = day;
                                  }

                                  setState(() {});
                                },
                              ))
                          .toList()))
                  .toList()
            ],
          ),
        ],
      ),
    );
  }
}
