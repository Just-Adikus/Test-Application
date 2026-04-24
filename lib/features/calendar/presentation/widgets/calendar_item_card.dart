import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:test_application/features/calendar/domain/entities/calendar_item.dart';

class CalendarItemCard extends StatelessWidget {
  final CalendarItem item;

  const CalendarItemCard({super.key, required this.item});

  String get _categoryLabel {
    return switch (item.category) {
      TaskCategory.personal => 'Личные задачи',
      TaskCategory.work => 'Рабочие задачи',
      TaskCategory.team => 'Командные задачи',
    };
  }

  Color get _dotColor {
    if (!item.hasIndicator) return Colors.transparent;
    return item.indicatorColor == IndicatorColor.green
        ? const Color(0xFF61DE70)
        : const Color(0xFFFFC239);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      padding: const EdgeInsets.fromLTRB(14, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: item.hasIndicator ? _dotColor : const Color(0xFFCCCCCC),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.authorName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _categoryLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.timeAgo,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFFAAAAAA),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Avatar(
                assetPath: item.authorAvatarAsset,
                networkUrl: item.authorAvatarUrl,
                radius: 22,
              ),
              const SizedBox(height: 12),
              _ProgressRing(percent: item.progressPercent),
            ],
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? assetPath;
  final String? networkUrl;
  final double radius;

  const _Avatar({this.assetPath, this.networkUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;

    if (assetPath != null) {
      provider = AssetImage(assetPath!);
    } else if (networkUrl != null) {
      provider = NetworkImage(networkUrl!);
    }

    if (provider != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: provider,
        backgroundColor: const Color(0xFFDDE3EC),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFDDE3EC),
      child: Icon(Icons.person, size: radius, color: const Color(0xFF9AAABB)),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  final int percent;
  const _ProgressRing({required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(52, 52),
            painter: _RingPainter(progress: percent / 100),
          ),
          Text(
            '$percent%',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A90D9),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  const _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;
    const stroke = 5.0;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = const Color(0xFFDDE8F7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * -math.pi * progress,
      false,
      Paint()
        ..color = const Color(0xFF4A90D9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
