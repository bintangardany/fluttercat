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
            'price': '100.000',
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
          {
            'imagePath': 'images/f3.jpg',
            'name': 'Lavaredo Watches by BEN NEVIS',
            'price': '100.000',
            'description':
                'Introducing the BEN NEVIS Men\'s Watches: Embrace minimalist fashion with this sleek and stylish wristwatch designed for men. Featuring an analog date display and a genuine leather strap, this timepiece combines simplicity with elegance. Stay on trend and elevate your look with the BEN NEVIS Men\'s Watch.',
          },
        ];
      case 'Sport':
        return [
          {
            'imagePath': 'images/s1.jpg',
            'name':
                'Digital Uwatch RunS Smart Watch Fitness Tracker Watches Digital Watch Waterproof | eBay',
            'price': '100.000',
            'description':
                'Find many great new & used options and get the best deals for Digital Uwatch RunS Smart Watch Fitness Tracker Watches Digital Watch Waterproof at the best online prices at eBay! Free shipping for many products!',
          },
          {
            'imagePath': 'images/s2.jpg',
            'name':
                'Ultimate Fitness Watch for Men and Women Waterproof Sleep Tracker Pedometer',
            'price': '100.000',
            'description':
                'Introducing the Waterproof Smart Watch with Sleep Tracker, Pedometer, and Multiple Sports Modes - the perfect fitness watch for both men and women. This innovative device is designed to help you achieve your fitness goals and keep track of your health effortlessly. With its advanced features and sleek design, it is the ideal companion for anyone who wants to stay fit and active. Here are five key benefits of the Waterproof Smart Watch: Sleep Tracker: Monitor your sleep patterns and improve your',
          },
        ];
      case 'Kids':
        return [
          {
            'imagePath': 'images/k1.jpg',
            'name':
                'Disney AVENGERS Kids Smart Watch, Digital, 41 mm, Rubber Strap, AVG4665',
            'price': '60.000',
            'description':
                'Disney avengers kids smart watch, digital, 41 mm, rubber strap, avg4665',
          },
          {
            'imagePath': 'images/k2.jpg',
            'name': 'Quartz WatchPOPETPOP Children Slap Watch - Slap Bracelets',
            'price': '60.000',
            'description':
                ' Quartz WatchPOPETPOP Children Slap Watch - Slap Bracelets for Girls Boys - Cartoon Funny Kids Quartz Watch Slap Wristwatch Toys for Students Kids (Tortoise) Check more at https://www.digitalcontentinsider.com/kids-quartz-watchpopetpop-children-slap-watch-slap-bracelets-for-girls-boys-cartoon-funny-kids-quartz-watch-slap-wristwatch-toys-for-students-kids-tortoise/',
          },
        ];
      // Tambahan kategori lainnya...
      default:
        return [];
    }
  }
}
