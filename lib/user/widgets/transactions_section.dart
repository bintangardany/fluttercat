import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Daftar transaksi yang belum diproses
  List<Transaction> pendingTransactions = [
    Transaction(
      orderId: '01',
      productName: 'Premium chat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'Pending',
    ),
    Transaction(
      orderId: '02',
      productName: 'Premium chat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'Pending',
    ),
  ];

  // Daftar transaksi yang sedang diproses
  List<Transaction> onProcessTransactions = [
    Transaction(
      orderId: '01',
      productName: 'Premium chat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'On Process',
    ),
    Transaction(
      orderId: '02',
      productName: 'Premium chat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'On Process',
    ),
  ];
  List<Transaction> successTransactions = [
    Transaction(
      orderId: '01',
      productName: 'Premium chat Food',
      price: 15000,
      imagePath: 'images/cat4.jpg',
      status: 'Success',
    )
  ];

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
                        // Gunakan TabBarView untuk menampilkan konten berdasarkan tab yang dipilih
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildTransactionList(
                                  pendingTransactions), // Tab Pending
                              _buildTransactionList(onProcessTransactions),
                              _buildTransactionList(
                                  successTransactions), // Tab On Process
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

  // Membuat AppBar
  Widget _buildAppBar() {
    return SliverAppBar(
      floating: false,
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('Order', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        background: Container(
          decoration: const BoxDecoration(color: Color(0xFF4A1E9E)),
        ),
      ),
    );
  }

  // Membuat TabBar
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

  // Menampilkan daftar transaksi
  Widget _buildTransactionList(List<Transaction> transactions) {
    if (transactions.isEmpty) {
      return _buildEmptyState(); // Menampilkan pesan kosong jika tidak ada transaksi
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _buildTransactionItem(transaction, index);
      },
    );
  }

  // Membuat item transaksi
  Widget _buildTransactionItem(Transaction transaction, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
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
                  Text(transaction.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Order ID: ${transaction.orderId}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  // Menampilkan status transaksi
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
                ],
              ),
            ),
            Text('Rp${transaction.price.toStringAsFixed(0)}'),
          ],
        ),
      ),
    );
  }

  // Menampilkan pesan jika tidak ada transaksi
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
            Navigator.pop(
                context); // Tombol untuk kembali ke halaman sebelumnya
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A1E9E),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text(
            'Mulai Belanja',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// Kelas untuk mendefinisikan struktur transaksi
class Transaction {
  final String orderId;
  final String productName;
  final double price;
  final String imagePath;
  final String status; // Status transaksi (Pending, On Process, Success)

  Transaction({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.status, // Initialize status
  });
}
