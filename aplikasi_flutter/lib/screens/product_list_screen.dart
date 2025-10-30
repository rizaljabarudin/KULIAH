import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasi_flutter/services/db_service.dart';
import 'package:aplikasi_flutter/models/product.dart';
import 'package:aplikasi_flutter/screens/product_edit_screen.dart';
import 'package:aplikasi_flutter/screens/cart_screen.dart';
import 'package:aplikasi_flutter/services/auth_service.dart';
import 'package:aplikasi_flutter/screens/login_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DBService>(context);
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NGOFA MANCING'),
        centerTitle: true,
        backgroundColor: Colors.teal[800],
      ),
      body: FutureBuilder<List<Product>>(
        future: db.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(
              child: Text('Belum ada produk. Tambah produk baru dulu.'),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) {
              final p = products[i];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.grey[900],
                child: ListTile(
                  leading: _buildImage(p.imagePath),
                  title: Text(
                    p.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Rp ${p.price.toStringAsFixed(0)} • Stok: ${p.stock}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.tealAccent),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductEditScreen(product: p),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () async {
                          await db.deleteProduct(p.id!);
                          setState(() {}); // refresh list
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingButtons(context, auth),
    );
  }

  /// Widget pembangun gambar produk (dengan validasi file)
  Widget _buildImage(String? path) {
    try {
      if (path != null && File(path).existsSync()) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(path),
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        );
      }
    } catch (_) {}
    return const Icon(Icons.shopping_bag, size: 45, color: Colors.white54);
  }

  /// Tombol aksi mengambang (cart, add, logout)
  Widget _buildFloatingButtons(BuildContext context, AuthService auth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'cart',
          backgroundColor: Colors.tealAccent[700],
          child: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const CartScreen())),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'add',
          backgroundColor: Colors.greenAccent[700],
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () => Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ProductEditScreen())),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'logout',
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            await auth.signOut();
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ],
    );
  }
}
