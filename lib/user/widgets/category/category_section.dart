import 'package:flutter/material.dart';
import 'category_item.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Categories Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A1E9E),
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: const [
              CategoryItem(
                  title: 'Fashion', icon: Icons.style, itemCount: '50+ items'),
              CategoryItem(
                  title: 'Sport', icon: Icons.sports, itemCount: '43+ items'),
              CategoryItem(
                  title: 'Kids',
                  icon: Icons.child_care,
                  itemCount: '20+ items'),
            ],
          ),
        ),
      ],
    );
  }
}
