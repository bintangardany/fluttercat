import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/all_products_page.dart';

class BannerSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 32.0,
          vertical: 20.0,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF4A1E9E),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.catching_pokemon, color: Colors.white, size: 80),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add your onPressed action here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AllProductsPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 12.0 : 16.0,
                            horizontal: isMobile ? 16.0 : 24.0,
                          ),
                          backgroundColor: Colors.deepPurple[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Pawsome Deals at Nyanco!',
                          style: TextStyle(
                            fontSize: isMobile ? 18.0 : 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Treat your furry friend to the best products and irresistible offers!',
                        style: TextStyle(
                          fontSize: isMobile ? 12.0 : 14.0,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
