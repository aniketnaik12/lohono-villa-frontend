import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class QuoteScreen extends StatefulWidget {
  final int villaId;
  final String checkIn;
  final String checkOut;

  const QuoteScreen({
    super.key,
    required this.villaId,
    required this.checkIn,
    required this.checkOut,
  });

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  Map? data;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    data = await ApiService.getQuote(
      widget.villaId,
      widget.checkIn,
      widget.checkOut,
    );
    setState(() => loading = false);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  String formatRange(DateTime start, DateTime end) {
    if (start.month == end.month && start.year == end.year) {
      return '${DateFormat('dd').format(start)}–${DateFormat('dd MMM yyyy').format(end)}';
    }
    return '${formatDate(start)} – ${formatDate(end)}';
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final villa = data!['villa'];
    final breakdown = data!['nightly_breakdown'];

    final checkInDate = DateTime.parse(widget.checkIn);
    final checkOutDate = DateTime.parse(widget.checkOut);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(villa['name']),
              background: Image.network(
                'https://vold-chain-hotel.s3-ap-southeast-1.amazonaws.com/60ebb4ff9dae8c2905fad8a9/villas/panoramic-one-bedroom-pool-villa/17518610844641/big/DPSAV-OneBedroomPoolVilla-aerial.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📍 Location
                  Text(
                    villa['location'],
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    formatRange(checkInDate, checkOutDate),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),
                  Text(
                    data!['is_available']
                        ? 'Available for selected dates'
                        : 'Not available for selected dates',
                    style: TextStyle(
                      color: data!['is_available']
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Price Breakdown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 10),
                  ...breakdown.map<Widget>((n) {
                    final date =
                        formatDate(DateTime.parse(n['date']));
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(date),
                          Text('₹${n['rate']}'),
                        ],
                      ),
                    );
                  }).toList(),

                  const Divider(height: 32),

                  _priceRow('Subtotal', data!['subtotal']),
                  _priceRow('GST (18%)', data!['gst']),
                  _priceRow(
                    'Total',
                    data!['total'],
                    isBold: true,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _priceRow(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            '₹$value',
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : null),
          ),
        ],
      ),
    );
  }
}
