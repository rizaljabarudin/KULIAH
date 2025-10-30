import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aplikasi_flutter/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: ListTile(
        leading: (product.imagePath != null && File(product.imagePath!).existsSync())
            ? Image.file(
                File(product.imagePath!),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.shopping_bag, size: 40),
        title: Text(
          product.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart, color: Colors.tealAccent),
          onPressed: onAddToCart,
        ),
      ),
    );
  }
}
