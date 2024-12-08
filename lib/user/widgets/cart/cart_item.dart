class CartItem {
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final int quantity;

  CartItem({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.quantity,
  });

  CartItem copyWith({
    String? name,
    String? imagePath,
    double? price,
    String? description,
    int? quantity,
  }) {
    return CartItem(
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
    );
  }
}
