import 'package:flutter/material.dart';
import '../checkout/checkout_page.dart';
import 'package:flutternews/user/widgets/cart/cart_item.dart';
import 'package:flutternews/user/widgets/product_detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Premium Cat Food',
      imagePath: 'images/cat4.jpg',
      price: 150000,
      description: 'Lorem ipsum odor amet, consectetuer adipiscing elit. Fames sed sit luctus sollicitudin pretium nullam. Commodo non congue lacus felis tempus sodales parturient porta nunc. Facilisi molestie feugiat blandit ipsum pharetra quisque ultricies. Luctus luctus vitae elementum turpis, tellus facilisi malesuada nam proin. Hac mattis arcu eros porttitor blandit neque convallis gravida?',
      quantity: 1,
    ),
    // CartItem(
    //   name: 'Premium Cat Food',
    //   imagePath: 'images/cat4.jpg',
    //   price: 150000,
    //   quantity: 2,
    // ),
    // CartItem(
    //   name: 'Premium Cat Food',
    //   imagePath: 'images/cat4.jpg',
    //   price: 150000,
    //   quantity: 3,
    // ),
  ];
  double shippingCost = 20000;
  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        cartItems.isEmpty
                            ? _buildEmptyCart()
                            : _buildCartItemsList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (cartItems.isNotEmpty) ...[_buildTotalAndCheckout()],
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Your Shopping Cart',
            style: TextStyle(color: Colors.white)),
        background: Container(
          decoration: const BoxDecoration(color: Color(0xFF4A1E9E)),
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
        const SizedBox(height: 20),
        Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 24, color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A1E9E),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text(
            'Start Shopping',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = cartItems[index];
        return _buildCartItem(cartItem, index);
      },
    );
  }

Widget _buildCartItem(CartItem cartItem, int index) {
  return Dismissible(
    key: Key(cartItem.name),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      _removeItem(index);
    },
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              imagePath: cartItem.imagePath,
              name: cartItem.name,
              price: cartItem.price.toString(),
              description: cartItem.description,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Gambar Produk
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  cartItem.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),

              // Informasi Produk
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Desc: ${cartItem.description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Rp ${cartItem.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A1E9E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Kontrol Kuantitas
              _buildQuantityControls(index, cartItem),
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildQuantityControls(int index, CartItem cartItem) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            _updateQuantity(index, cartItem.quantity - 1);
          },
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(
            '${cartItem.quantity}',
            key: ValueKey<int>(cartItem.quantity),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () {
            _updateQuantity(index, cartItem.quantity + 1);
          },
        ),
      ],
    );
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
      } else {
        _removeItem(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  Widget _buildTotalAndCheckout() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          // BoxShadow(
          //     color: Colors.grey.withOpacity(0.3),
          //     spreadRadius: 1,
          //     blurRadius: 3,
          //     offset: const Offset(0, -3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Total Price Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  'Rp ${totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A1E9E)),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 16), // Spacer between total and checkout button

          // Checkout Button Section
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutPage(
                              totalPrice: totalPrice,
                              cartItems: cartItems,
                            )));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: const Color(0xFF4A1E9E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              child: const Text(
                'Checkout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
