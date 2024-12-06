import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/category_products.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String itemCount;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProducts(category: title),
          ),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.only(right: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF4A1E9E)),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                itemCount,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
