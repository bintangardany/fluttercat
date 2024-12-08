import 'package:flutter/material.dart';
import '../product_item.dart';
import 'all_products_page.dart'; // Import the new page

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A1E9E),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllProductsPage(),
                    ),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A1E9E),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 260,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              ProductItem(
                imagePath: 'images/cat4.jpg',
                name: 'Premium Cat Food',
                price: '150.000',
                description: 'Lorem ipsum odor amet, consectetuer adipiscing elit. Fames sed sit luctus sollicitudin pretium nullam. Commodo non congue lacus felis tempus sodales parturient porta nunc. Facilisi molestie feugiat blandit ipsum pharetra quisque ultricies. Luctus luctus vitae elementum turpis, tellus facilisi malesuada nam proin. Hac mattis arcu eros porttitor blandit neque convallis gravida?',
              ),
              ProductItem(
                imagePath: 'images/cat4.jpg',
                name: 'Cozy Cat Bed',
                price: '39.000',
                description: 'Comfortable sleep',
              ),
              ProductItem(
                imagePath: 'images/cat4.jpg',
                name: 'Grooming Kit',
                price: '24.000',
                description: 'Complete cat care',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
