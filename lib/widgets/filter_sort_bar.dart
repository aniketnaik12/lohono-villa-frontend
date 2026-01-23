import 'package:flutter/material.dart';

class FilterSortBar extends StatelessWidget {
  final VoidCallback onFilterTap;
  final VoidCallback onSortTap;

  const FilterSortBar({
    super.key,
    required this.onFilterTap,
    required this.onSortTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFF6F6F6),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onFilterTap,
              icon: const Icon(Icons.tune),
              label: const Text('Filters'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onSortTap,
              icon: const Icon(Icons.swap_vert),
              label: const Text('Sort'),
            ),
          ),
        ],
      ),
    );
  }
}
