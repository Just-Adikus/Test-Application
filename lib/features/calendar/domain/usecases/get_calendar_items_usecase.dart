import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';
import 'package:test_application/features/calendar/domain/repositories/calendar_repository.dart';

class GetCalendarItemsUseCase {
  final CalendarRepository _repository;

  GetCalendarItemsUseCase(this._repository);

  Future<List<CalendarItem>> call(CalendarItemType type) {
    return _repository.getCalendarItems(type);
  }
}
