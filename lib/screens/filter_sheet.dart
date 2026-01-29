import 'package:flutter/material.dart';
class FilterResult {
  final List<String> tags;
  final RangeValues? priceRange;

  FilterResult({
    required this.tags,
    required this.priceRange,
  });
}

class FilterSheet extends StatefulWidget {
  final List<String> selectedTags;
  final RangeValues? priceRange;

  const FilterSheet({
    super.key,
    required this.selectedTags,
    this.priceRange,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late List<String> tags;
  late RangeValues range;

  @override
  void initState() {
    super.initState();
    tags = [...widget.selectedTags];
    range = widget.priceRange ?? const RangeValues(30000, 60000);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          // 💰 Price range
          const Text('Price per night'),
          RangeSlider(
            values: range,
            min: 20000,
            max: 80000,
            divisions: 12,
            labels: RangeLabels(
              '₹${range.start.toInt()}',
              '₹${range.end.toInt()}',
            ),
            onChanged: (v) => setState(() => range = v),
          ),

          const SizedBox(height: 12),

          // 🏷 Tags
          const Text('Tags'),
          Wrap(
            spacing: 8,
            children: [
              _chip('Pet-friendly'),
              _chip('Event-friendly'),
              _chip('Senior-friendly'),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    FilterResult(
                      tags: [],
                      priceRange: null,
                    ),
                  );
                },
                child: const Text('Clear'),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    FilterResult(
                      tags: tags,
                      priceRange: range,
                    ),
                  );
                },
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String tag) {
    final selected = tags.contains(tag);
    return FilterChip(
      label: Text(tag),
      selected: selected,
      onSelected: (v) {
        setState(() {
          v ? tags.add(tag) : tags.remove(tag);
        });
      },
    );
  }
}
