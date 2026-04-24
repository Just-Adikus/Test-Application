import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';
import 'package:test_application/features/calendar/domain/usecases/get_calendar_items_usecase.dart';
import 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final GetCalendarItemsUseCase _getCalendarItems;

  CalendarCubit(this._getCalendarItems) : super(CalendarInitial());

  Future<void> loadItems([CalendarFilter filter = CalendarFilter.task]) async {
    emit(CalendarLoading(filter));

    try {
      final type = switch (filter) {
        CalendarFilter.task => CalendarItemType.task,
        CalendarFilter.event => CalendarItemType.event,
        CalendarFilter.activity => CalendarItemType.activity,
      };

      final items = await _getCalendarItems(type);

      final taskItems =
          filter == CalendarFilter.task
              ? items
              : await _getCalendarItems(CalendarItemType.task);
      final eventItems =
          filter == CalendarFilter.event
              ? items
              : await _getCalendarItems(CalendarItemType.event);
      final activityItems =
          filter == CalendarFilter.activity
              ? items
              : await _getCalendarItems(CalendarItemType.activity);

      emit(
        CalendarLoaded(
          items: items,
          activeFilter: filter,
          taskCount: taskItems.length,
          eventCount: eventItems.length,
          activityCount: activityItems.length,
        ),
      );
    } catch (e) {
      emit(CalendarError(e.toString()));
    }
  }

  void changeFilter(CalendarFilter filter) => loadItems(filter);
}
