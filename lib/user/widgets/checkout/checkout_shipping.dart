import 'package:flutter/material.dart';

class ShippingOptions extends StatelessWidget {
  final String selectedOption;
  final Map<String, double> options;
  final ValueChanged<String> onSelected;

  const ShippingOptions({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shipping Options',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Column(
            children: options.entries.map((option) {
              return RadioListTile<String>(
                title: Text(
                  '${option.key} (Rp ${option.value.toStringAsFixed(0)})',
                  style: const TextStyle(fontSize: 14),
                ),
                value: option.key,
                groupValue: selectedOption,
                onChanged: (value) => onSelected(value!),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
