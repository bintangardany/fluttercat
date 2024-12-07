import 'package:flutter/material.dart';
import '../product_item.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            const Text('All Products', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1E9E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 16.0, // Space between columns
            mainAxisSpacing: 16.0, // Space between rows
            childAspectRatio: 0.7, // Aspect ratio for each item (height/width)
          ),
          itemCount: 9, // The number of items you want to display
          itemBuilder: (context, index) {
            return ProductItem(
              imagePath: 'images/cat4.jpg',
              name: 'Premium Cat Food',
              price: '29.000',
              description: 'High-quality nutrition',
            );
          },
        ),
      ),
    );
  }
}
