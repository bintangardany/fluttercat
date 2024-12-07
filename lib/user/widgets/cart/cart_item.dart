class CartItem {
  final String name;
  final String imagePath;
  final double price;
  final int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    String? name,
    String? imagePath,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
