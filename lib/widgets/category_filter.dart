import 'package:flutter/material.dart';

import '../models/post.dart';
import '../theme/app_theme.dart';

class CategoryFilter extends StatelessWidget {
  final PostCategory? selected; // null = Semua
  final ValueChanged<PostCategory?> onChanged;

  const CategoryFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  Widget _pill(String label, PostCategory? value) {
    final active = selected == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.pillInactive,
          borderRadius: BorderRadius.circular(24),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color(0x332859E8),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]
              : const [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 220),
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : AppColors.textPrimary,
          ),
          child: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _pill('Semua', null),
          const SizedBox(width: 8),
          _pill('Akademik', PostCategory.akademik),
          const SizedBox(width: 8),
          _pill('Event', PostCategory.event),
        ],
      ),
    );
  }
}