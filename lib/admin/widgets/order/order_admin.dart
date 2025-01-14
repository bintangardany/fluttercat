import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/order/transactions_item.dart';

class OrderAdmin extends StatefulWidget {
  const OrderAdmin({super.key});

  @override
  State<OrderAdmin> createState() => _OrderAdminState();
}

class _OrderAdminState extends State<OrderAdmin>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Transaction> pendingOrders = [
    Transaction(
      orderId: '0123456789',
      productName: 'Premium Cat Food',
      price: 150000,
      imagePath: 'images/cat4.jpg',
      status: 'Pending',
      description: 'Premium cat food description',
      quantity: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1E9E),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Pending',
            ),
            Tab(text: 'On Process'),
            Tab(text: 'Completed'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(pendingOrders),
          _buildOrderList([]), // On Process orders
          _buildOrderList([]), // Completed orders
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Transaction> orders) {
    if (orders.isEmpty) {
      return const Center(child: Text('No orders found'));
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Transaction order) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text('Order #${order.orderId}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${order.productName}'),
            Text('Quantity: ${order.quantity}'),
            Text(
                'Total: Rp${(order.price * order.quantity).toStringAsFixed(0)}'),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleOrderAction(value, order),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'process',
              child: Text(
                'Process Order',
              ),
            ),
            const PopupMenuItem(
              value: 'complete',
              child: Text('Complete Order'),
            ),
            const PopupMenuItem(
              value: 'cancel',
              child: Text(
                'Cancel Order',
              ),
            ),
          ],
        ),
        onTap: () => _showOrderDetails(order),
      ),
    );
  }

  void _handleOrderAction(String action, Transaction order) {
    // Implement order status changes
    switch (action) {
      case 'process':
        // Update order status to "On Process"
        break;
      case 'complete':
        // Update order status to "Completed"
        break;
      case 'cancel':
        // Cancel the order
        break;
    }
  }

  void _showOrderDetails(Transaction order) {
    // Show detailed order information
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.orderId}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(order.imagePath,
                  height: 100, width: 100, fit: BoxFit.cover),
              const SizedBox(height: 8),
              Text('Product: ${order.productName}'),
              Text('Description: ${order.description}'),
              Text('Quantity: ${order.quantity}'),
              Text('Price: Rp${order.price.toStringAsFixed(0)}'),
              Text(
                  'Total: Rp${(order.price * order.quantity).toStringAsFixed(0)}'),
              Text('Status: ${order.status}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
