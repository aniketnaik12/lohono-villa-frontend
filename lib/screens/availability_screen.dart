import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/villa_card.dart';
import 'quote_screen.dart';
import '../widgets/search_summary.dart';
import '../widgets/filter_sort_bar.dart';
import 'filter_sheet.dart';
import 'sort_sheet.dart';


class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  bool loading = true;
  List villas = [];

  final checkIn = '2025-01-10';
  final checkOut = '2025-01-13';

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      villas = await ApiService.getAvailability(checkIn, checkOut);
    } catch (_) {}
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: const Color(0xFFF6F6F6),
  appBar: AppBar(
    title: const Text("Available Villa's"),
    elevation: 0,
  ),
  body: Column(
    children: [
      SearchSummary(onTap: () {}),
      FilterSortBar(
        onFilterTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const FilterSheet(),
          );
        },
        onSortTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const SortSheet(),
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Luxury villas in Goa · ${villas.length} properties found',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: villas
                    .map((v) => VillaCard(
                          villa: v,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => QuoteScreen(
                                  villaId: v['id'],
                                  checkIn: checkIn,
                                  checkOut: checkOut,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
      ),
    ],
  ),
);

  }
}
