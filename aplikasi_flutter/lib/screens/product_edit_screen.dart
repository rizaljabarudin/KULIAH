import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:aplikasi_flutter/models/product.dart';
import 'package:aplikasi_flutter/services/db_service.dart';

class ProductEditScreen extends StatefulWidget {
  final Product? product;
  const ProductEditScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  final _stock = TextEditingController();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _name.text = widget.product!.name;
      _desc.text = widget.product!.description;
      _price.text = widget.product!.price.toString();
      _stock.text = widget.product!.stock.toString();
      _imagePath = widget.product!.imagePath;
    }
  }

  Future pickImage() async {
    final picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _imagePath = file.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = DBService.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: _price,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _stock,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              _imagePath != null
                  ? Image.file(File(_imagePath!), height: 120)
                  : const SizedBox(
                      height: 120,
                      child: Center(child: Text('Tidak ada gambar')),
                    ),
              TextButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Pilih Gambar'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  final p = Product(
                    id: widget.product?.id,
                    uuid: widget.product?.uuid ?? const Uuid().v4(),
                    name: _name.text.trim(),
                    description: _desc.text.trim(),
                    price: double.tryParse(_price.text.trim()) ?? 0,
                    stock: int.tryParse(_stock.text.trim()) ?? 0,
                    imagePath: _imagePath,
                  );

                  if (widget.product == null) {
                    await db.addProduct(p);
                  } else {
                    await db.updateProduct(p);
                  }

                  Navigator.of(context).pop();
                },
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
