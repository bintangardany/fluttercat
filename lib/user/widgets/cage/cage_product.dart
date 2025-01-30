import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/category/category_products.dart';
import '../product_item.dart';

class CageProducts extends StatelessWidget {
  const CageProducts({super.key});

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
                'Kids Products',
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
                      builder: (context) => CategoryProducts(category: 'Kids'),
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
                imagePath: 'images/k1.jpg',
                name:
                    'Disney AVENGERS Kids Smart Watch, Digital, 41 mm, Rubber Strap, AVG4665',
                price: '60.000',
                description:
                    'Disney avengers kids smart watch, digital, 41 mm, rubber strap, avg4665',
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
