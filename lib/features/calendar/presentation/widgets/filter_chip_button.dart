import 'package:flutter/material.dart';

class FilterChipButton extends StatelessWidget {
  final String label;
  final int? count;
  final bool isSelected;
  final Color activeColor;
  final VoidCallback onTap;

  const FilterChipButton({
    super.key,
    required this.label,
    this.count,
    required this.isSelected,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : const Color(0xFFE2E2E2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : const Color(0xFF9E9E9E),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
