import 'package:flutter/material.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text(
              'Sort By',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          ListTile(
            title: const Text('Popularity'),
            onTap: () {
              Navigator.pop(context, {
                'sort': 'avg_price_per_night',
                'order': 'ASC',
              });
            },
          ),

          ListTile(
            title: const Text('Price: Low to High'),
            onTap: () {
              Navigator.pop(context, {
                'sort': 'avg_price_per_night',
                'order': 'ASC',
              });
            },
          ),

          ListTile(
            title: const Text('Price: High to Low'),
            onTap: () {
              Navigator.pop(context, {
                'sort': 'avg_price_per_night',
                'order': 'DESC',
              });
            },
          ),
        ],
      ),
    );
  }
}
