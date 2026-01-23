import 'package:flutter/material.dart';
import 'rating_badge.dart';
import 'tag_chip.dart';

class VillaCard extends StatelessWidget {
  final Map villa;
  final VoidCallback onTap;

  const VillaCard({
    super.key,
    required this.villa,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                'https://vold-chain-hotel.s3-ap-southeast-1.amazonaws.com/60ebb4ff9dae8c2905fad8a9/villas/panoramic-one-bedroom-pool-villa/17518610844641/big/DPSAV-OneBedroomPoolVilla-aerial.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // 📄 Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    villa['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    villa['location'],
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 10),
                  RatingBadge(
                    rating: villa['rating'].toDouble(),
                    count: villa['review_count'],
                  ),

                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 6,
                    runSpacing: -8,
                    children: (villa['tags'] as List)
                        .map((t) => TagChip(t))
                        .toList(),
                  ),

                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${villa['avg_price_per_night']} / night',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
