import 'package:flutter/material.dart';

class SortSheet extends StatelessWidget {
  const SortSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ListTile(title: Text('Sort By')),
        ListTile(
          title: const Text('Popularity'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: const Text('Price: Low to High'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          title: const Text('Price: High to Low'),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
