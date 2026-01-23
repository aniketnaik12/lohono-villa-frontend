import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final double rating;
  final int count;

  const RatingBadge({super.key, required this.rating, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 14),
        const SizedBox(width: 4),
        Text('$rating ($count)',
            style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
