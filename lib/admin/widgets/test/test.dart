import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String? imagePath;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imagePath,
    required this.description,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
    );
  }
}

class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({Key? key}) : super(key: key);

  @override
  _AdminProductScreenState createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  final List<Product> _products = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imagePicker = ImagePicker();
  String? _editingProductId;
  String? _selectedImagePath;
  bool _isTableView = false;

  @override
  void initState() {
    super.initState();
    _loadInitialProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _loadInitialProducts() {
    setState(() {
      _products.addAll([
        Product(
          id: '1',
          name: 'Premium Cat Food',
          description:
              'Lorem ipsum odor amet, consectetuer adipiscing elit. Est netus hac arcu sem volutpat. Montes diam sed sem id natoque pharetra varius',
          price: 150000,
          imagePath: null,
        ),
      ]);
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _showProductForm(BuildContext context,
      [Product? product]) async {
    if (product != null) {
      _nameController.text = product.name;
      _descriptionController.text = product.description ?? '';
      _priceController.text = product.price.toString();
      _editingProductId = product.id;
      _selectedImagePath = product.imagePath;
    } else {
      _clearForm();
    }

    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product == null ? 'Add Product' : 'Edit Product'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_selectedImagePath!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add_photo_alternate, size: 40),
                              SizedBox(height: 8),
                              Text('Tap to add image'),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixText: 'Rp ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _clearForm();
              Navigator.of(ctx).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text(product == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_editingProductId == null) {
        _addProduct();
      } else {
        _updateProduct();
      }
      Navigator.of(context).pop();
    }
  }

  void _addProduct() {
    setState(() {
      _products.add(Product(
        id: DateTime.now().toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        imagePath: _selectedImagePath,
      ));
    });
    _clearForm();
  }

  void _updateProduct() {
    setState(() {
      final index = _products.indexWhere((p) => p.id == _editingProductId);
      if (index != -1) {
        _products[index] = _products[index].copyWith(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          price: double.parse(_priceController.text),
          imagePath: _selectedImagePath,
        );
      }
    });
    _clearForm();
  }

  Future<void> _deleteProduct(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed ?? false) {
      setState(() {
        _products.removeWhere((p) => p.id == id);
      });
    }
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _editingProductId = null;
    _selectedImagePath = null;
  }

  Widget _buildTableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Image')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _products.map((product) {
            return DataRow(cells: [
              DataCell(
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: product.imagePath != null
                      ? Image.file(
                          File(product.imagePath!),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 50,
                          height: 50,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                ),
              ),
              DataCell(Text(product.name)),
              DataCell(Text('Rp ${product.price.toStringAsFixed(0)}')),
              DataCell(Text(product.description ?? '-')),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.green),
                    onPressed: () => _showProductForm(context, product),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(product.id),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Admin Product Management',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1E9E),
        actions: [
          IconButton(
            icon: Icon(_isTableView ? Icons.list : Icons.grid_on),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _isTableView = !_isTableView;
              });
            },
          ),
        ],
      ),
      body: _products.isEmpty
          ? const Center(
              child: Text('No products available. Add some products!'),
            )
          : _isTableView
              ? _buildTableView()
              : ListView.builder(
                  itemCount: _products.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (ctx, index) {
                    final product = _products[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: product.imagePath != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.file(
                                  File(product.imagePath!),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child:
                                    const Icon(Icons.image, color: Colors.grey),
                              ),
                        title: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rp ${product.price.toStringAsFixed(0)}',
                                style: const TextStyle()),
                            if (product.description != null)
                              Text(
                                product.description!,
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis, // Add ellipsis if the text is too long
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.green),
                              onPressed: () =>
                                  _showProductForm(context, product),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteProduct(product.id),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProductForm(context),
        backgroundColor: const Color(0xFF4A1E9E),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
