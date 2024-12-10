import 'package:flutter/material.dart';
import 'package:flutternews/user/user_home.dart';
import 'package:flutternews/user/widgets/cart/chart_page.dart';

class ProductDetailPage extends StatefulWidget {
  final String imagePath;
  final String name;
  final String price;
  final String description;

  const ProductDetailPage({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'product-${widget.name}',
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            _buildGradientOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductName(),
          const SizedBox(height: 8),
          _buildProductPrice(),
          const SizedBox(height: 16),
          _buildProductDescription(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.name,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProductPrice() {
    return Text(
      'Rp ${widget.price}',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A1E9E),
      ),
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.description,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 1,
        //     blurRadius: 3,
        //     offset: const Offset(0, -3),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF4A1E9E),
                side: const BorderSide(color: Color(0xFF4A1E9E)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Chat Admin',
                style: TextStyle(color: Color(0xFF4A1E9E)),
              ),
            ),
          ),
          const SizedBox(width: 8), // tambahkan spasi antara tombol
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A1E9E),
                foregroundColor: const Color(0xFF4A1E9E),
                side: const BorderSide(color: Color(0xFF4A1E9E)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
