import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';

class CalendarItemModel extends CalendarItem {
  const CalendarItemModel({
    required super.id,
    required super.authorName,
    super.authorAvatarUrl,
    super.authorAvatarAsset,
    required super.category,
    required super.title,
    required super.timeAgo,
    required super.progressPercent,
    required super.type,
    super.hasIndicator,
    super.indicatorColor,
  });

  factory CalendarItemModel.fromJson(Map<String, dynamic> json) {
    return CalendarItemModel(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      authorAvatarAsset: json['authorAvatarAsset'] as String?,
      category: TaskCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
      title: json['title'] as String,
      timeAgo: json['timeAgo'] as String,
      progressPercent: json['progressPercent'] as int,
      type: CalendarItemType.values.firstWhere((e) => e.name == json['type']),
      hasIndicator: json['hasIndicator'] as bool? ?? false,
      indicatorColor: IndicatorColor.values.firstWhere(
        (e) => e.name == (json['indicatorColor'] ?? 'yellow'),
        orElse: () => IndicatorColor.yellow,
      ),
    );
  }
}
