import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';

abstract class CalendarRepository {
  Future<List<CalendarItem>> getCalendarItems(CalendarItemType type);
}
