import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/category/category_products.dart';
import '../product_item.dart';

class FoodProducts extends StatelessWidget {
  const FoodProducts({super.key});

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
                'Sport Products',
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
                      builder: (context) => CategoryProducts(category: 'Sport'),
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
                imagePath: 'images/s1.jpg',
                name:
                    'Digital Uwatch RunS Smart Watch Fitness Tracker Watches Digital Watch Waterproof | eBay',
                price: '100.000',
                description:
                    'Find many great new & used options and get the best deals for Digital Uwatch RunS Smart Watch Fitness Tracker Watches Digital Watch Waterproof at the best online prices at eBay! Free shipping for many products!',
              ),
              ProductItem(
                imagePath: 'images/s2.jpg',
                name:
                    'Ultimate Fitness Watch for Men and Women Waterproof Sleep Tracker Pedometer',
                price: '100.000',
                description:
                    'Introducing the Waterproof Smart Watch with Sleep Tracker, Pedometer, and Multiple Sports Modes - the perfect fitness watch for both men and women. This innovative device is designed to help you achieve your fitness goals and keep track of your health effortlessly. With its advanced features and sleek design, it is the ideal companion for anyone who wants to stay fit and active. Here are five key benefits of the Waterproof Smart Watch: Sleep Tracker: Monitor your sleep patterns and improve your',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
