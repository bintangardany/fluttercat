import 'package:flutter/material.dart';
import 'package:flutternews/user/widgets/order/transactions_Detail.dart';
import 'transactions_section.dart';
import 'transactions_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const EmptyState();
    }

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return TransactionItem(transaction: transaction);
      },
    );
  }
}

// Widget untuk Item Transaksi
class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  const TransactionItem({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail order
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailPage(transaction: transaction),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(top: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
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
                    Text(
                      transaction.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Quantity: ${transaction.quantity}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
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
                  ],
                ),
              ),
              Text(
                'Rp${(transaction.price * transaction.quantity).toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
