import 'package:flutter/material.dart';
import '../product_item.dart';

class AllProductsPage extends StatelessWidget {
  const AllProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> allProducts = _getAllProducts();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Featured Products',
            style: TextStyle(color: Colors.white)),
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
          itemCount: allProducts.length,
          itemBuilder: (context, index) {
            return ProductItem(
              imagePath: allProducts[index]['imagePath']!,
              name: allProducts[index]['name']!,
              price: allProducts[index]['price']!,
              description: allProducts[index]['description']!,
            );
          },
        ),
      ),
    );
  }

  List<Map<String, String>> _getAllProducts() {
    final List<Map<String, String>> allProducts = [];

    // Fashion Products
    allProducts.addAll([
      {
        'imagePath': 'images/f1.jpg',
        'name': 'OLEVS Mens Watches Minimalist Ultra Thin Fashion Casual',
        'price': '100.000',
        'description':
            'Japan Quartz movement, button battery - could use for 2-3 years,Hardlex crystal glass - high hardness,durables, scratch resistant mineral, genuine leather, - better breathability,durables and a comfortable wearing experience.',
      },
      {
        'imagePath': 'images/f2.jpg',
        'name': 'CLU Watch Minuit Ladies - Default Title / Black',
        'price': '100.000',
        'description':
            'Cluse Watch Minuit Ladies CL30022. Our Minuit collection pays tribute to starry nights and elegant evening looks.',
      },
      {
        'imagePath': 'images/f3.jpg',
        'name': 'Lavaredo Watches by BEN NEVIS',
        'price': '100.000',
        'description':
            'Introducing the BEN NEVIS Men\'s Watches: Embrace minimalist fashion with this sleek and stylish wristwatch designed for men.',
      },
    ]);

    // Sport Products
    allProducts.addAll([
      {
        'imagePath': 'images/s1.jpg',
        'name': 'Digital Uwatch RunS Smart Watch Fitness Tracker',
        'price': '100.000',
        'description':
            'Digital Uwatch RunS Smart Watch Fitness Tracker Watches Digital Watch Waterproof',
      },
      {
        'imagePath': 'images/s2.jpg',
        'name': 'Ultimate Fitness Watch for Men and Women',
        'price': '100.000',
        'description':
            'Waterproof Smart Watch with Sleep Tracker, Pedometer, and Multiple Sports Modes',
      },
    ]);

    // Kids Products
    allProducts.addAll([
      {
        'imagePath': 'images/k1.jpg',
        'name': 'Disney AVENGERS Kids Smart Watch',
        'price': '60.000',
        'description':
            'Disney avengers kids smart watch, digital, 41 mm, rubber strap, avg4665',
      },
      {
        'imagePath': 'images/k2.jpg',
        'name': 'Quartz WatchPOPETPOP Children Slap Watch',
        'price': '60.000',
        'description':
            'Children Slap Watch - Slap Bracelets for Girls Boys - Cartoon Funny Kids Quartz Watch',
      },
    ]);

    return allProducts;
  }
}
