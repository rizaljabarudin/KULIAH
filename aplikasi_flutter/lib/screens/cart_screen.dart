import 'package:flutter/material.dart';
import 'package:aplikasi_flutter/models/cart_item.dart';
import 'package:aplikasi_flutter/models/alat_pancing.dart';
import 'package:aplikasi_flutter/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> initialItems;

  const CartScreen({super.key, this.initialItems = const []});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _items;

  @override
  void initState() {
    super.initState();
    // Salin isi keranjang agar tidak mengubah data asli
    _items = List.from(widget.initialItems);
  }

  double get totalHarga {
    return _items.fold(
      0,
      (sum, item) => sum + (item.product.harga * item.quantity),
    );
  }

  void _tambahQuantity(int index) {
    setState(() => _items[index].quantity++);
  }

  void _kurangiQuantity(int index) {
    setState(() {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Keranjang masih kosong 🛒',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : Column(
              children: [
                Expanded(child: _buildListKeranjang()),
                _buildTotalSection(context),
              ],
            ),
    );
  }

  // 🛍️ Daftar produk di keranjang
  Widget _buildListKeranjang() {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final product = item.product;

        return Card(
          color: Colors.grey[850],
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: _buildGambarProduk(product),
            title: Text(
              product.nama,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Qty: ${item.quantity} × Rp ${product.harga.toStringAsFixed(0)}',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: _buildTombolKuantitas(index, item.quantity),
          ),
        );
      },
    );
  }

  // 🖼️ Gambar produk
  Widget _buildGambarProduk(AlatPancing product) {
    final gambar = product.gambarUrl;
    if (gambar != null && gambar.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          gambar,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported, color: Colors.white54),
        ),
      );
    }

    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.white54,
      ),
    );
  }

  // ➕➖ Tombol tambah/kurang jumlah
  Widget _buildTombolKuantitas(int index, int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove_circle_outline,
            color: Colors.tealAccent,
          ),
          onPressed: () => _kurangiQuantity(index),
        ),
        Text(
          '$quantity',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.tealAccent),
          onPressed: () => _tambahQuantity(index),
        ),
      ],
    );
  }

  // 💰 Bagian total harga dan tombol checkout
  Widget _buildTotalSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Total: Rp ${totalHarga.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.payment, color: Colors.black),
              label: const Text(
                'Lanjut ke Checkout',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: _items.isEmpty
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutScreen(items: _items),
                        ),
                      );
                    },
            ),
          ),
        ],
      ),
    );
  }
}
