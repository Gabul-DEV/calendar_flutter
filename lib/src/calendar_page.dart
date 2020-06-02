import 'package:calendar_calendar/src/calendar_page_controller.dart';
import 'package:calendar_calendar/src/models/date.dart';
import 'package:calendar_calendar/src/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class Calendar extends StatefulWidget {
  final Color activeColor;
  final Color backgroundColor;
  final TextStyle selectedStyle;
  final TextStyle textStyleDays;
  final TextStyle textStyleWeekDay;
  final TextStyle titleStyle;
  final bool weekendOpacityEnable;
  final double weekendOpacity;
  final bool disable;
  final ValueChanged<Date> onSelected;
  final DateTime initialDate;

  final Widget previous;
  final Widget next;

  final double space;

  Calendar({
    Key key,
    this.titleStyle,
    this.previous,
    this.next,
    this.activeColor,
    this.backgroundColor,
    this.selectedStyle,
    this.textStyleDays,
    this.textStyleWeekDay,
    this.onSelected,
    this.space,
    this.weekendOpacityEnable = false,
    this.weekendOpacity = 0.48,
    this.disable = false,
    this.initialDate,
  })  : assert(weekendOpacityEnable == true
            ? textStyleWeekDay.color != null
            : true),
        assert(
            weekendOpacityEnable == true ? textStyleDays.color != null : true),
        super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  CalendarPageController controller;
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 1);
    controller = CalendarPageController(pageController, widget.initialDate);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      color: widget.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: controller.update,
                    initialData: PageDirection.none,
                    builder: (context, snapshot) {
                      return Text(
                        "${controller.dataCollection.currentMonth.month.month}, ${controller.dataCollection.currentMonth.year}",
                        style: widget.titleStyle,
                      );
                    }),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.previous != null)
                      GestureDetector(
                        child: widget.previous,
                        onTap: widget.disable == true
                            ? null
                            : () {
                                pageController.previousPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              },
                      ),
                    SizedBox(
                      width: widget.space,
                    ),
                    if (widget.previous != null)
                      GestureDetector(
                        child: widget.next,
                        onTap: widget.disable == true
                            ? null
                            : () {
                                pageController.nextPage(
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              },
                      )
                  ],
                ),
              ],
            ),
          ),
          Table(
            children: [
              TableRow(
                  children: List.generate(
                      7,
                      (index) => Container(
                              child: Center(
                            child: Text(
                              index.week,
                              style: widget.textStyleWeekDay.copyWith(
                                  color: widget.weekendOpacityEnable
                                      ? index == 0 || index == 6
                                          ? widget.textStyleWeekDay.color
                                              .withOpacity(
                                                  widget.weekendOpacity)
                                          : widget.textStyleWeekDay.color
                                      : null),
                            ),
                          )))),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: StreamBuilder<PageDirection>(
                stream: controller.update.stream,
                builder: (context, snapshot) => PageView(
                      controller: pageController,
                      onPageChanged: controller.onChage,
                      children: [
                        CalendarWidget(
                          key: Key(controller.dataCollection.previousMonth.key),
                          date: controller.dataCollection.previousMonth,
                          onSelected:
                              widget.disable == true ? null : widget.onSelected,
                          backgroundColor: widget.backgroundColor,
                          activeColor: widget.activeColor,
                          selectedStyle: widget.selectedStyle,
                          textStyleDays: widget.textStyleDays,
                          textStyleWeekDay: widget.textStyleWeekDay,
                          titleStyle: widget.titleStyle,
                          pageController: pageController,
                          previous: widget.previous,
                          next: widget.next,
                          weekendOpacityEnable: widget.weekendOpacityEnable,
                          weekendOpacity: widget.weekendOpacity,
                        ),
                        CalendarWidget(
                          key: Key(controller.dataCollection.currentMonth.key),
                          date: controller.dataCollection.currentMonth,
                          onSelected:
                              widget.disable == true ? null : widget.onSelected,
                          backgroundColor: widget.backgroundColor,
                          activeColor: widget.activeColor,
                          selectedStyle: widget.selectedStyle,
                          textStyleDays: widget.textStyleDays,
                          textStyleWeekDay: widget.textStyleWeekDay,
                          titleStyle: widget.titleStyle,
                          pageController: pageController,
                          previous: widget.previous,
                          next: widget.next,
                          weekendOpacityEnable: widget.weekendOpacityEnable,
                          weekendOpacity: widget.weekendOpacity,
                        ),
                        CalendarWidget(
                          key: Key(controller.dataCollection.nextMonth.key),
                          date: controller.dataCollection.nextMonth,
                          onSelected:
                              widget.disable == true ? null : widget.onSelected,
                          backgroundColor: widget.backgroundColor,
                          activeColor: widget.activeColor,
                          selectedStyle: widget.selectedStyle,
                          textStyleDays: widget.textStyleDays,
                          textStyleWeekDay: widget.textStyleWeekDay,
                          titleStyle: widget.titleStyle,
                          pageController: pageController,
                          previous: widget.previous,
                          next: widget.next,
                          weekendOpacityEnable: widget.weekendOpacityEnable,
                          weekendOpacity: widget.weekendOpacity,
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
