import 'package:equatable/equatable.dart';
import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';

enum CalendarFilter { task, event, activity }

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {
  final CalendarFilter activeFilter;
  const CalendarLoading(this.activeFilter);

  @override
  List<Object?> get props => [activeFilter];
}

class CalendarLoaded extends CalendarState {
  final List<CalendarItem> items;
  final CalendarFilter activeFilter;
  final int taskCount;
  final int eventCount;
  final int activityCount;

  const CalendarLoaded({
    required this.items,
    required this.activeFilter,
    required this.taskCount,
    required this.eventCount,
    required this.activityCount,
  });

  @override
  List<Object?> get props => [
    items,
    activeFilter,
    taskCount,
    eventCount,
    activityCount,
  ];
}

class CalendarError extends CalendarState {
  final String message;
  const CalendarError(this.message);

  @override
  List<Object?> get props => [message];
}
