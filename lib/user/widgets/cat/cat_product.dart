import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/category/category_products.dart';
import '../product_item.dart';

class CatProducts extends StatelessWidget {
  const CatProducts({super.key});

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
                'Fashion Products',
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
                      builder: (context) => CategoryProducts(
                        category: 'Fashion',
                      ),
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
                imagePath: 'images/f2.jpg',
                name: 'CLU Watch Minuit Ladies - Default Title / Black',
                price: '100.000',
                description:
                    'Cluse Watch Minuit Ladies CL30022. Our Minuit collection pays tribute to starry nights and elegant evening looks. The delicate design of this featherlight watch makes it the perfect accessory for a fashionable, yet subtle result. The watch features a 33 mm case, where black is combined with rose gold details to create a beautiful minimalist timepiece. The strap can be easily interchanged, allowing you to personalise your watch.',
              ),
              ProductItem(
                imagePath: 'images/f3.jpg',
                name: 'Lavaredo Watches by BEN NEVIS',
                price: '100.000',
                description:
                    'Introducing the BEN NEVIS Men\'s Watches: Embrace minimalist fashion with this sleek and stylish wristwatch designed for men. Featuring an analog date display and a genuine leather strap, this timepiece combines simplicity with elegance. Stay on trend and elevate your look with the BEN NEVIS Men\'s Watch.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
