import 'dart:ui';

import 'package:flutter/material.dart';
import 'cart_item.dart';

class CheckoutPage extends StatelessWidget {
  final double totalPrice;
  final double shippingCost;
  final List<CartItem> cartItems;

  const CheckoutPage({
    super.key,
    required this.totalPrice,
    required this.shippingCost,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text('Checkout', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1E9E),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildAddressSection(),
                const Divider(thickness: 1),
                _buildCartItemsList(),
                const Divider(thickness: 1),
                _buildPaymentDetails(),
              ],
            ),
          ),
          _buildConfirmPaymentButton(context),
        ],
      ),
    );
  }

  Widget _buildAddressSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF4A1E9E), size: 32),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Delivery Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Jakarta, Indonesia',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to edit address
            },
            child: const Text(
              'Edit',
              style: TextStyle(color: Color(0xFF4A1E9E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: cartItems.map((item) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(item.imagePath,
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          'quantity: ${item.quantity}',
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rp ${(item.price * item.quantity).toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPaymentDetails() {
    final subtotal = cartItems.fold<double>(
        0.0, (sum, item) => sum + (item.price * item.quantity));
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal', style: TextStyle(fontSize: 14)),
              Text('Rp ${subtotal.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Shipping Cost', style: TextStyle(fontSize: 14)),
              Text('Rp ${shippingCost.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
          const Divider(thickness: 1, height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                'Rp ${(subtotal + shippingCost).toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A1E9E)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPaymentButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          _showPaymentSuccessDialog(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF4A1E9E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        child: const Text(
          'Confirm Payment',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Thank you for your purchase!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to previous page
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
