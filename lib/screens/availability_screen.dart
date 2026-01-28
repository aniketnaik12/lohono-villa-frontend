import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/villa_card.dart';
import 'quote_screen.dart';
import '../widgets/search_summary.dart';
import '../widgets/filter_sort_bar.dart';
import 'filter_sheet.dart';
import 'sort_sheet.dart';

const LOCATIONS = ['All', 'Goa', 'Lonavala', 'Alibaug', 'Coorg'];

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  bool loading = false;
  List villas = [];

  String selectedLocation = 'All';
  String? searchQuery;
  List<String> selectedTags = [];
  String sort = 'avg_price_per_night';
  String order = 'ASC';

  DateTime? checkIn;
  DateTime? checkOut;

  String _fmt(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> pickDates() async {
  final result = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2025, 1, 1),
    lastDate: DateTime(2025, 12, 31),
  );

  if (result != null) {
    setState(() {
      checkIn = result.start;
      checkOut = result.end;
    });
    load();
  }
}

  void openSearchOptions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
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
                'Edit Search',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 16),

              // Location
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Location'),
                subtitle: Text(selectedLocation),
                onTap: () async {
                  final result = await showModalBottomSheet<String>(
                    context: context,
                    builder: (_) =>
                        LocationSheet(selectedLocation: selectedLocation),
                  );

                  if (result != null) {
                    setState(() {
                      selectedLocation = result;

                      if (result == 'All') {
                        searchQuery = null; // remove filter
                      } else {
                        searchQuery = result; // apply filter
                      }
                    });
                    load();
                  }
                },
              ),

              // Dates
              ListTile(
                leading: const Icon(Icons.date_range),
                title: const Text('Dates'),
                subtitle: Text(
                  checkIn == null
                      ? 'Add dates'
                      : '${_fmt(checkIn!)} → ${_fmt(checkOut!)}',
                ),
                onTap: () {
                  Navigator.pop(context);
                  pickDates();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // -------------------------
  // API call
  // -------------------------
  Future<void> load() async {
    if (checkIn == null || checkOut == null) return;

    setState(() => loading = true);
    try {
      villas = await ApiService.getAvailability(
        checkIn: _fmt(checkIn!),
        checkOut: _fmt(checkOut!),
        search: searchQuery,
        tags: selectedTags,
        sort: sort,
        order: order,
        // location can be passed later if backend supports it
      );
    } catch (e) {
      debugPrint('Availability error: $e');
    }
    setState(() => loading = false);
  }

  // -------------------------
  // UI
  // -------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text(
          selectedLocation == 'All' ? 'All Locations' : selectedLocation,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔎 Search summary
          SearchSummary(
            label: checkIn == null
                ? '${selectedLocation == 'All' ? 'All Locations' : selectedLocation} · Add Date · Add Guests'
                : '${selectedLocation == 'All' ? 'All Locations' : selectedLocation} · ${_fmt(checkIn!)} → ${_fmt(checkOut!)}',
            onTap: openSearchOptions,
          ),

          FilterSortBar(
            onFilterTap: () async {
              final result = await showModalBottomSheet<List<String>>(
                context: context,
                isScrollControlled: true,
                builder: (_) => FilterSheet(selectedTags: selectedTags),
              );

              if (result != null) {
                setState(() => selectedTags = result);
                load();
              }
            },
            onSortTap: () async {
              final result = await showModalBottomSheet<Map<String, String>>(
                context: context,
                builder: (_) => const SortSheet(),
              );

              if (result != null) {
                setState(() {
                  sort = result['sort']!;
                  order = result['order']!;
                });
                load();
              }
            },
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Luxury villas in $selectedLocation · ${villas.length} properties found',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),

          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : checkIn == null
                ? const Center(child: Text('Select dates to view availability'))
                : villas.isEmpty
                ? const Center(
                    child: Text(
                      'No villas available for selected dates or filters',
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: villas.length,
                    itemBuilder: (context, index) {
                      final v = villas[index];
                      return VillaCard(
                        villa: v,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuoteScreen(
                                villaId: v['id'],
                                checkIn: _fmt(checkIn!),
                                checkOut: _fmt(checkOut!),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class LocationSheet extends StatelessWidget {
  final String selectedLocation;

  const LocationSheet({super.key, required this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: LOCATIONS.map((location) {
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(location),
            trailing: location == selectedLocation
                ? const Icon(Icons.check)
                : null,
            onTap: () => Navigator.pop(context, location),
          );
        }).toList(),
      ),
    );
  }
}
