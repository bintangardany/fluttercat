import 'package:flutter/material.dart';
import 'package:flutternews/user/user_home.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List of pending transactions
  List<Transaction> pendingTransactions = [
    Transaction(
      orderId: '01',
      productName: 'Premium Cat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'Pending',
      quantity: 2,
    ),
  ];

  // List of transactions in process
  List<Transaction> onProcessTransactions = [];

  // List of successful transactions
  List<Transaction> successTransactions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                        _buildTabBar(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildTransactionList(pendingTransactions),
                              _buildTransactionList(onProcessTransactions),
                              _buildTransactionList(successTransactions),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build AppBar
  Widget _buildAppBar() {
    return SliverAppBar(
      floating: false,
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title:
            const Text('Order History', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        background: Container(
          decoration: const BoxDecoration(color: Color(0xFF4A1E9E)),
        ),
      ),
    );
  }

  // Build TabBar
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Pending'),
        Tab(text: 'On Process'),
        Tab(text: 'Success'),
      ],
    );
  }

  // Display transaction list
  Widget _buildTransactionList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildTransactionItem(transaction);
      },
    );
  }

  // Build transaction item
  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(transaction.imagePath,
                  width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ID: ${transaction.orderId}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(transaction.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    'Quantity: ${transaction.quantity}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
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
                                : Colors.green),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
            Text(
              'Rp${(transaction.price * transaction.quantity).toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Display message if no transactions
  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
        const SizedBox(height: 20),
        Text(
          'No Order',
          style: TextStyle(fontSize: 24, color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHome(),
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A1E9E),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text(
            'Order Now',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Class to define transaction structure
class Transaction {
  final String orderId;
  final String productName;
  final double price;
  final String imagePath;
  final String status;
  final int quantity;

  Transaction({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.status,
    required this.quantity,
  });
}
