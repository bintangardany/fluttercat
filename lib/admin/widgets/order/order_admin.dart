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
      description: 'Premium cat food for your cat',
      quantity: 2,
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
          style: TextStyle(color: Colors.white, fontSize: 24),
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
          unselectedLabelColor: Colors.white70,
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
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Image.network(
          order.imagePath,
          height: 80,
          width: 80,
          fit: BoxFit.cover,
        ),
        title: Text(
          'Order #${order.orderId}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${order.productName}',
              style: TextStyle(),
            ),
            Text('Quantity: ${order.quantity}'),
            Text('Rp${(order.price * order.quantity).toStringAsFixed(0)}'),
            Text(
              order.status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: order.status == 'Pending'
                    ? Colors.orange
                    : order.status == 'On Process'
                        ? Colors.blue
                        : Colors.green,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) => _handleOrderAction(value, order),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'process',
              child: Text('Process Order'),
            ),
            const PopupMenuItem(
              value: 'complete',
              child: Text('Complete Order'),
            ),
            const PopupMenuItem(
              value: 'cancel',
              child: Text('Cancel Order'),
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
        break;
      case 'complete':
        break;
      case 'cancel':
        break;
    }
  }

  void _showOrderDetails(Transaction order) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order #${order.orderId}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order.imagePath,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          order.productName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          order.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          order.status,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: order.status == 'Pending'
                                ? Colors.orange
                                : order.status == 'On Process'
                                    ? Colors.blue
                                    : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Quantity', '${order.quantity}'),
              _buildInfoRow('Price', 'Rp${order.price.toStringAsFixed(0)}'),
              _buildInfoRow('Total',
                  'Rp${(order.price * order.quantity).toStringAsFixed(0)}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
