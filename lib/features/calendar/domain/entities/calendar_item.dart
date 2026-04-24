enum CalendarItemType { task, event, activity }

enum TaskCategory { personal, work, team }

enum IndicatorColor { green, yellow, none }

class CalendarItem {
  final String id;
  final String authorName;
  final String? authorAvatarUrl;
  final String? authorAvatarAsset;
  final TaskCategory category;
  final String title;
  final String timeAgo;
  final int progressPercent;
  final CalendarItemType type;
  final bool hasIndicator;
  final IndicatorColor indicatorColor;

  const CalendarItem({
    required this.id,
    required this.authorName,
    this.authorAvatarUrl,
    this.authorAvatarAsset,
    required this.category,
    required this.title,
    required this.timeAgo,
    required this.progressPercent,
    required this.type,
    this.hasIndicator = false,
    this.indicatorColor = IndicatorColor.yellow,
  });
}
