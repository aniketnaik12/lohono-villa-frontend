import 'package:flutter/material.dart';

class SearchSummary extends StatelessWidget {
  final VoidCallback onTap;

  const SearchSummary({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
            )
          ],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Location · Add Date · Add Guests',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.edit, size: 16),
          ],
        ),
      ),
    );
  }
}
