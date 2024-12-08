import 'package:flutter/material.dart';
import 'transactions_item.dart';

class OrderDetailPage extends StatefulWidget {
  final Transaction transaction; // Assuming you already have this model

  const OrderDetailPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  double shippingCost = 0.0;
  String selectedShippingOption = 'COD'; // Default shipping option

  final Map<String, double> shippingOptions = {
    'JNE': 10000,
    'J&T': 12000,
    'SiCepat': 9000,
    'COD': 0, // Cash on Delivery is free
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title:
            const Text('Order Detail', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1E9E),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildOrderSection(),
                const Divider(thickness: 1),
                _buildTransactionDetailSection(),
                const Divider(thickness: 1),
                _buildAddressSection(),
                const Divider(thickness: 1),
                _buildShippingOptionsSection(),
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

  Widget _buildOrderSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
      child: Row(
        children: [
          Text(
            'Order Id: ${widget.transaction.orderId}',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF4A1E9E),
                fontWeight: FontWeight.bold),
          ),
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
                  'Jakarta, Indonesia ',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Transaction detail section (Order info)
  Widget _buildTransactionDetailSection() {
    final transaction = widget.transaction;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                transaction.imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),

            // Informasi Transaksi
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Quantity: ${transaction.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    transaction.status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: transaction.status == 'Pending'
                          ? Colors.orange
                          : transaction.status == 'On Process'
                              ? Colors.blue
                              : Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            // Total Harga
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Rp ${(transaction.price * transaction.quantity).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A1E9E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Shipping options dropdown
  Widget _buildShippingOptionsSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Shipping Options',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: selectedShippingOption,
            onChanged: (value) {
              setState(() {
                selectedShippingOption = value!;
                shippingCost = shippingOptions[
                    selectedShippingOption]!; // Update shipping cost based on selection
              });
            },
            items: shippingOptions.keys
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
          ),
          const SizedBox(height: 8),
          Text(
            'Shipping Cost: Rp ${shippingCost.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    final subtotal = widget.transaction.price * widget.transaction.quantity;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Payment Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Implement confirmation logic here
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xFF4A1E9E),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        child: const Text(
          'Chat Admin',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
