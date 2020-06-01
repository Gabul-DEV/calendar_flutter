import 'package:calendar_calendar/src/models/day.dart';
import 'package:flutter/material.dart';

class DayWidget extends StatelessWidget {
  final Day day;
  final TextStyle style;
  final Color activeColor;
  final Color backgroundColor;
  final Function onTap;
  final bool isSelected;
  final double radius;
  const DayWidget(
      {Key key,
      this.day,
      this.style,
      this.onTap,
      this.activeColor,
      this.isSelected = false,
      this.radius = 20,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: day.value == 0 ? null : onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: isSelected ? activeColor : backgroundColor,
        child: Text(
          day.label,
          style: isSelected
              ? style?.copyWith(
                  color: activeColor.computeLuminance() > 0.4
                      ? Colors.white
                      : Colors.black)
              : style,
        ),
      ),
    );
  }
}
