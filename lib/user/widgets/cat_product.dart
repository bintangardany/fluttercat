import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/category_products.dart';
import 'product_item.dart';

class CatProducts extends StatelessWidget {
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
                'Cat Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A1E9E),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the full product list page (AllProductsPage)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProducts(category: 'Cat'),
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
                price: '29.000',
                description: 'High-quality nutrition',
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
