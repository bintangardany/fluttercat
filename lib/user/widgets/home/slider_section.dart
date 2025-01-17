import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutternews/user/user_home.dart';

class EnhancedPromoSlider extends StatefulWidget {
  const EnhancedPromoSlider({Key? key}) : super(key: key);

  @override
  _EnhancedPromoSliderState createState() => _EnhancedPromoSliderState();
}

class _EnhancedPromoSliderState extends State<EnhancedPromoSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> promotions = [
    {
      'title': 'Product Sale!',
      'subtitle': 'On all products',
      'icon': Icons.discount,
      'color': Colors.indigo[900],
    },
    {
      'title': 'Free Shipping!',
      'subtitle': 'For orders today',
      'icon': Icons.local_shipping,
      'color': Colors.orange[900],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < promotions.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 220,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: promotions.length,
            itemBuilder: (context, index) {
              final promo = promotions[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: promo['color'],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            promo['title'],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black26,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            promo['subtitle'],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black26,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserHome()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Shop Now',
                              style: TextStyle(
                                color: Color(0xFF4A1E9E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: AnimatedScale(
                        scale: _currentPage == index ? 1.1 : 0.9,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Icon(
                          promo['icon'],
                          size: 80,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            promotions.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? Color(0xFF4A1E9E) : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
