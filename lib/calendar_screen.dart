import 'package:event_calendar/component/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'model/event.dart';

class CalendarScreen extends StatefulWidget {
  CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedEvent = ValueNotifier(event[DateTime.now()] ?? []);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _selectedEvent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: defaultPadding,
            right: defaultPadding),
        color: surfaceColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome 21September',
                    style: textTheme.headline6!.copyWith(color: primaryColor)),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('LOGOUT',
                      style: textTheme.button!.copyWith(color: Colors.white)),
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: Text(
                'Your course schedule',
                style: textTheme.subtitle1!.copyWith(color: Colors.white),
              ),
            ),
            CustomCalendar(onSelectedDay: (day) {
              _selectedEvent.value = event[day] ?? [];
            }),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _selectedEvent,
                builder: (context, dynamic value, _) {
                  return value.isEmpty
                      ? Container(
                          child: Text('NO DATA'),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              child: ListTile(
                                title: Text(value[index].title),
                                subtitle: Text(value[index].description),
                              ),
                            );
                          },
                          itemCount: value.length,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
