import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  double price;
  int stock;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
  });
}

class AdminProductScreen extends StatefulWidget {
  @override
  _AdminProductScreenState createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  List<Product> products = [];
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String? _editingProductId;

  @override
  void initState() {
    super.initState();
    // Contoh data produk
    products.add(
        Product(id: '1', name: 'Premium Cat Food', price: 150000, stock: 10));
    products.add(
        Product(id: '2', name: 'Premium Cat Food', price: 150000, stock: 15));
  }

  void _showProductForm(BuildContext context, [Product? product]) {
    if (product != null) {
      _nameController.text = product.name;
      _priceController.text = product.price.toString();
      _stockController.text = product.stock.toString();
      _editingProductId = product.id;
    } else {
      _clearForm();
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _priceController,
                decoration:
                    InputDecoration(labelText: 'Price', prefixText: 'Rp '),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextField(
                controller: _stockController,
                decoration: InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_editingProductId == null) {
                _addProduct();
              } else {
                _updateProduct();
              }
              Navigator.of(ctx).pop();
            },
            child: Text(product == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _addProduct() {
    setState(() {
      products.add(Product(
        id: DateTime.now().toString(),
        name: _nameController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        stock: int.tryParse(_stockController.text) ?? 0,
      ));
    });
    _clearForm();
  }

  void _updateProduct() {
    setState(() {
      final index = products.indexWhere((p) => p.id == _editingProductId);
      if (index != -1) {
        products[index] = Product(
          id: _editingProductId!,
          name: _nameController.text,
          price: double.tryParse(_priceController.text) ?? 0,
          stock: int.tryParse(_stockController.text) ?? 0,
        );
      }
    });
    _clearForm();
  }

  void _deleteProduct(String id) {
    setState(() {
      products.removeWhere((p) => p.id == id);
    });
  }

  void _clearForm() {
    _nameController.clear();
    _priceController.clear();
    _stockController.clear();
    _editingProductId = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Admin Product Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4A1E9E),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (ctx, index) {
                final product = products[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        'Price: Rp ${product.price}, Stock: ${product.stock}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showProductForm(context, product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(product.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductForm(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF4A1E9E),
      ),
    );
  }
}
