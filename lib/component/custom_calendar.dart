import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:event_calendar/constants.dart';
import 'package:event_calendar/model/event.dart';

class CustomCalendar extends StatefulWidget {
  final Function(DateTime day)? onSelectedDay;
  const CustomCalendar({Key? key, this.onSelectedDay}) : super(key: key);

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  List<Event> _getEvent(DateTime day) {
    return event[day] ?? [];
  }

  void _onSelectedDay(DateTime selectedDay, DateTime focusDay) {
    setState(() {
      if (!isSameDay(_focusedDay, selectedDay)) {
        _focusedDay = focusDay;
      }
    });
    widget.onSelectedDay!(focusDay);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(_focusedDay.year - 30, 1, 1),
          lastDay: DateTime.utc(_focusedDay.year + 30, 1, 1),
          headerStyle: HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: textTheme.subtitle2!.copyWith(color: Colors.white),
            leftChevronIcon:
                const Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon:
                const Icon(Icons.chevron_right, color: Colors.white),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: textTheme.caption!.copyWith(color: Colors.white),
            weekendStyle: textTheme.caption!.copyWith(color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            defaultTextStyle: textTheme.caption!.copyWith(color: Colors.white),
            weekendTextStyle: textTheme.caption!.copyWith(color: Colors.white),
            outsideTextStyle:
                textTheme.caption!.copyWith(color: secondaryColor),
            markersAnchor: 0,
            markerDecoration: BoxDecoration(
              color: secondaryColor,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 1,
          ),
          onDaySelected: _onSelectedDay,
          selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
          calendarBuilders: CalendarBuilders(
            selectedBuilder: (context, day, focusedDay) => Container(
              margin:
                  EdgeInsets.only(top: 5.5, left: 7.5, right: 7.5, bottom: 7.5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                day.day.toString(),
                style: textTheme.caption!.copyWith(color: Colors.white),
              ),
            ),
            todayBuilder: (context, day, focusedDay) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                day.day.toString(),
                style: textTheme.caption!.copyWith(color: Colors.white),
              ),
            ),
          ),
          eventLoader: _getEvent,
          calendarFormat: _calendarFormat,
        ),
        Container(
          color: backgroundColor,
          child: GestureDetector(
            child: Container(
              color: surfaceColor,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'SHOW MORE',
                  style: textTheme.caption!.copyWith(color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                if (_calendarFormat == CalendarFormat.week) {
                  _calendarFormat = CalendarFormat.month;
                } else {
                  _calendarFormat = CalendarFormat.week;
                }
              });
            },
            onPanUpdate: (position) {
              double y = position.globalPosition.dy;
              print('${y}');
              setState(() {
                if (y < 0) {
                  _calendarFormat = CalendarFormat.week;
                } else if (y > 30) {
                  _calendarFormat = CalendarFormat.month;
                }
              });
            },
          ),
        )
      ],
    );
  }
}
