import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/alat_pancing.dart'; // pastikan model ini sesuai

class AddEditScreen extends StatefulWidget {
  final AlatPancing? alat;

  const AddEditScreen({super.key, this.alat});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  late TextEditingController _namaController;
  late TextEditingController _deskripsiController;
  late TextEditingController _hargaController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.alat?.nama ?? '');
    _deskripsiController = TextEditingController(text: widget.alat?.deskripsi ?? '');
    _hargaController = TextEditingController(
      text: widget.alat != null ? widget.alat!.harga.toString() : '',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final alat = AlatPancing(
        id: widget.alat?.id ?? _uuid.v4(),
        nama: _namaController.text.trim(),
        deskripsi: _deskripsiController.text.trim(),
        harga: double.tryParse(_hargaController.text) ?? 0.0,
        gambarUrl: widget.alat?.gambarUrl ?? '', // tambahkan ini agar tidak error
      );

      Navigator.pop(context, {'alat': alat});
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.alat != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Alat Pancing' : 'Tambah Alat Pancing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Alat',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Deskripsi harus diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Harga harus diisi' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  child: Text(isEdit ? 'Simpan Perubahan' : 'Tambah'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
