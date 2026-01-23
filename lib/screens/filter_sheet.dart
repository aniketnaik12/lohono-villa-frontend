import 'package:flutter/material.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),

          const SizedBox(height: 16),
          const Text('Price Range'),
          RangeSlider(
            values: const RangeValues(30000, 60000),
            min: 20000,
            max: 80000,
            onChanged: (_) {},
          ),

          const SizedBox(height: 12),
          const Text('Tags'),
          Wrap(
            spacing: 8,
            children: const [
              FilterChip(label: Text('Pet-friendly'), selected: false, onSelected: null),
              FilterChip(label: Text('Event-friendly'), selected: false, onSelected: null),
              FilterChip(label: Text('Senior-friendly'), selected: false, onSelected: null),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('Clear')),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Apply'),
              )
            ],
          )
        ],
      ),
    );
  }
}
