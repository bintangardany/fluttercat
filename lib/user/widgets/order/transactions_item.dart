class Transaction {
  final String orderId;
  final String productName;
  final double price;
  final String imagePath;
  final String status;
  final String description;
  final int quantity;

  Transaction({
    required this.orderId,
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.status,
    required this.description,
    required this.quantity,
  });
}
