import 'package:flutter/material.dart';
import '../product_item.dart';

class CategoryProducts extends StatelessWidget {
  final String category;

  const CategoryProducts({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> products =
        _getProductsForCategory(category);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '$category Products',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1E9E),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 2 / 3, // Proporsi ukuran lebih ramping
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductItem(
                imagePath: products[index]['imagePath']!,
                name: products[index]['name']!,
                price: products[index]['price']!,
                description: products[index]['description']!,
              );
            },
          ),
        ),
      ),
    );
  }

  /// Mengembalikan daftar produk berdasarkan kategori
  List<Map<String, String>> _getProductsForCategory(String category) {
    switch (category) {
      case 'Fashion':
        return [
          {
            'imagePath': 'images/f1.jpg',
            'name': 'OLEVS Mens Watches Minimalist Ultra Thin Fashion Casual',
            'price': '43.530',
            'description':
                'Japan Quartz movement, button battery - could use for 2-3 years,Hardlex crystal glass - high hardness,durables, scratch resistant mineral, genuine leather, - better breathability,durables and a comfortable wearing experience.',
          },
          {
            'imagePath': 'images/f2.jpg',
            'name': 'CLU Watch Minuit Ladies - Default Title / Black',
            'price': '100.000',
            'description':
                'Cluse Watch Minuit Ladies CL30022. Our Minuit collection pays tribute to starry nights and elegant evening looks. The delicate design of this featherlight watch makes it the perfect accessory for a fashionable, yet subtle result. The watch features a 33 mm case, where black is combined with rose gold details to create a beautiful minimalist timepiece. The strap can be easily interchanged, allowing you to personalise your watch.',
          },
        ];
      case 'Food':
        return [
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Tree',
            'price': '49.000',
            'description': 'Perfect play tower for your cat',
          },
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Scratcher',
            'price': '29.000',
            'description': 'Keep your cat\'s claws healthy',
          },
        ];
      case 'Cage':
        return [
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Tree',
            'price': '49.000',
            'description': 'Perfect play tower for your cat',
          },
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Scratcher',
            'price': '29.000',
            'description': 'Keep your cat\'s claws healthy',
          },
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Scratcher',
            'price': '29.000',
            'description': 'Keep your cat\'s claws healthy',
          },
          {
            'imagePath': 'images/cat4.jpg',
            'name': 'Cat Scratcher',
            'price': '29.000',
            'description': 'Keep your cat\'s claws healthy',
          },
        ];
      // Tambahan kategori lainnya...
      default:
        return [];
    }
  }
}
