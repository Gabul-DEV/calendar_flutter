import 'package:calendar/src/calendar_page_controller.dart';
import 'package:calendar/src/widgets/calendar_widget.dart';
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
  final ValueChanged<Date> onSelected;

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
    @required this.onSelected,
    this.space,
    this.weekendOpacityEnable = false,
    this.weekendOpacity = 0.48,
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
    controller = CalendarPageController(pageController);

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
            child: Expanded(
              flex: 1,
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
                        InkWell(
                          highlightColor: Colors.grey[500],
                          focusColor: Colors.grey[500],
                          child: widget.previous,
                          onTap: () {
                            pageController.previousPage(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                        ),
                      SizedBox(
                        width: widget.space,
                      ),
                      if (widget.previous != null)
                        InkWell(
                          child: widget.next,
                          onTap: () {
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
          Expanded(
            flex: 2,
            child: StreamBuilder<PageDirection>(
                stream: controller.update.stream,
                builder: (context, snapshot) => PageView(
                      controller: pageController,
                      onPageChanged: controller.onChage,
                      children: [
                        CalendarWidget(
                          key: Key(controller.dataCollection.previousMonth.key),
                          date: controller.dataCollection.previousMonth,
                          onSelected: widget.onSelected,
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
                          onSelected: widget.onSelected,
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
                          onSelected: widget.onSelected,
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
          Expanded(flex: 1, child: Container())
        ],
      ),
    );
  }
}
