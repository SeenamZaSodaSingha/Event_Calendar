import 'dart:collection';

class Event {
  final String title;

  const Event(this.title);
}

final today = DateTime.now();
final firstDay = DateTime.utc(today.year, today.month - 3, 1);
final lastDay = DateTime.utc(today.year, today.month + 3, 1);

final eventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(firstDay.year, firstDay.month, item * 5):
        List.generate(item % 4 + 1, (index) => Event('$index'))
};

final event = HashMap<DateTime, List<Event>>()..addAll(eventSource);
