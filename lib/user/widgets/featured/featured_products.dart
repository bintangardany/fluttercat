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
                imagePath: 'images/f1.jpg',
                name: 'OLEVS Mens Watches Minimalist Ultra Thin Fashion Casual',
                price: '100.000',
                description:
                    'Japan Quartz movement, button battery - could use for 2-3 years,Hardlex crystal glass - high hardness,durables, scratch resistant mineral, genuine leather, - better breathability,durables and a comfortable wearing experience.',
              ),
              ProductItem(
                imagePath: 'images/s2.jpg',
                name:
                    'Ultimate Fitness Watch for Men and Women Waterproof Sleep Tracker Pedometer',
                price: '100.000',
                description:
                    'Introducing the Waterproof Smart Watch with Sleep Tracker, Pedometer, and Multiple Sports Modes - the perfect fitness watch for both men and women. This innovative device is designed to help you achieve your fitness goals and keep track of your health effortlessly. With its advanced features and sleek design, it is the ideal companion for anyone who wants to stay fit and active. Here are five key benefits of the Waterproof Smart Watch: Sleep Tracker: Monitor your sleep patterns and improve your',
              ),
              ProductItem(
                imagePath: 'images/k2.jpg',
                name:
                    'Quartz WatchPOPETPOP Children Slap Watch - Slap Bracelets',
                price: '60.000',
                description:
                    ' Quartz WatchPOPETPOP Children Slap Watch - Slap Bracelets for Girls Boys - Cartoon Funny Kids Quartz Watch Slap Wristwatch Toys for Students Kids (Tortoise) Check more at https://www.digitalcontentinsider.com/kids-quartz-watchpopetpop-children-slap-watch-slap-bracelets-for-girls-boys-cartoon-funny-kids-quartz-watch-slap-wristwatch-toys-for-students-kids-tortoise/',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
