import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  final List<String> selectedTags;

  const FilterSheet({
    super.key,
    required this.selectedTags,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.selectedTags);
  }

  void toggleTag(String tag) {
    setState(() {
      if (_tags.contains(tag)) {
        _tags.remove(tag);
      } else {
        _tags.add(tag);
      }
    });
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
            children: [
              _buildChip('Pet-friendly'),
              _buildChip('Event-friendly'),
              _buildChip('Senior-friendly'),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() => _tags.clear());
                },
                child: const Text('Clear'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _tags);
                },
                child: const Text('Apply'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: _tags.contains(label),
      onSelected: (_) => toggleTag(label),
    );
  }
}
