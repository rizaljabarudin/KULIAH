import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:aplikasi_flutter/models/cart_item.dart';

class CheckoutScreen extends StatelessWidget {
  final List<CartItem> items;
  CheckoutScreen({super.key, required this.items});

  double get total =>
      items.fold(0, (sum, e) => sum + (e.product.harga * e.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: items
                    .map(
                      (item) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: item.product.gambarUrl.isNotEmpty
                              ? Image.network(
                                  item.product.gambarUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image_not_supported),
                          title: Text(item.product.nama),
                          subtitle: Text(
                            'Qty: ${item.quantity} × Rp ${item.product.harga.toStringAsFixed(0)}',
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
            Text(
              'Total: Rp ${total.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.payment),
                label: const Text('Bayar Sekarang'),
                onPressed: () {
                  final id = const Uuid().v4();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Transaksi Berhasil ✅'),
                      content: Text(
                        'ID Transaksi: $id\nTotal Pembayaran: Rp ${total.toStringAsFixed(0)}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(
                              context,
                            ); // kembali ke halaman sebelumnya
                          },
                          child: const Text('Selesai'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
