import 'package:test_application/features/calendar/data/models/calendar_item_model.dart';
import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';
import 'package:test_application/features/calendar/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  static const List<Map<String, dynamic>> _tasksMock = [
    {
      'id': '1',
      'authorName': 'Арсений Иванченко',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Материал для блога',
      'timeAgo': '2 дня назад',
      'progressPercent': 45,
      'type': 'task',
      'hasIndicator': true,
      'indicatorColor': 'green',
    },
    {
      'id': '2',
      'authorName': 'Арсений Иванченко',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Материал для блога',
      'timeAgo': '2 дня назад',
      'progressPercent': 45,
      'type': 'task',
      'hasIndicator': true,
      'indicatorColor': 'yellow',
    },
    {
      'id': '3',
      'authorName': 'Арсений Иванченко',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Материал для блога',
      'timeAgo': '2 дня назад',
      'progressPercent': 45,
      'type': 'task',
      'hasIndicator': false,
      'indicatorColor': 'none',
    },
    {
      'id': '4',
      'authorName': 'Арсений Иванченко',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Материал для блога',
      'timeAgo': '2 дня назад',
      'progressPercent': 45,
      'type': 'task',
      'hasIndicator': false,
      'indicatorColor': 'none',
    },
    {
      'id': '5',
      'authorName': 'Арсений Иванченко',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Материал для блога',
      'timeAgo': '2 дня назад',
      'progressPercent': 45,
      'type': 'task',
      'hasIndicator': false,
      'indicatorColor': 'none',
    },
  ];

  static const List<Map<String, dynamic>> _eventsMock = [
    {
      'id': '6',
      'authorName': 'Мария Сидорова',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'work',
      'title': 'Совещание по проекту',
      'timeAgo': '1 день назад',
      'progressPercent': 70,
      'type': 'event',
      'hasIndicator': true,
      'indicatorColor': 'green',
    },
    {
      'id': '7',
      'authorName': 'Алексей Петров',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'team',
      'title': 'Ретроспектива спринта',
      'timeAgo': '3 дня назад',
      'progressPercent': 100,
      'type': 'event',
      'hasIndicator': true,
      'indicatorColor': 'yellow',
    },
  ];

  static const List<Map<String, dynamic>> _activitiesMock = [
    {
      'id': '8',
      'authorName': 'Ольга Козлова',
      'authorAvatarAsset': 'assets/avatar.jpg',
      'category': 'personal',
      'title': 'Корпоративный тимбилдинг',
      'timeAgo': '5 дней назад',
      'progressPercent': 20,
      'type': 'activity',
      'hasIndicator': true,
      'indicatorColor': 'yellow',
    },
  ];

  @override
  Future<List<CalendarItem>> getCalendarItems(CalendarItemType type) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final raw = switch (type) {
      CalendarItemType.task => _tasksMock,
      CalendarItemType.event => _eventsMock,
      CalendarItemType.activity => _activitiesMock,
    };
    return raw.map(CalendarItemModel.fromJson).toList();
  }
}
