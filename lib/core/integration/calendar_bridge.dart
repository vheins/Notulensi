import 'package:add_2_calendar/add_2_calendar.dart';

class CalendarBridge {
  /// Opens the native system calendar app with pre-filled event data.
  Future<bool> addEvent({
    required String title,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
    bool allDay = false,
  }) async {
    final Event event = Event(
      title: title,
      description: description,
      location: 'Notulensi App',
      startDate: startDate,
      endDate: endDate ?? startDate.add(const Duration(hours: 1)),
      allDay: allDay,
    );

    return await Add2Calendar.addEvent2Cal(event);
  }
}
