import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For demo: transactions are not persisted in local DB. If you integrate Firestore, show user's transactions here.
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Transaksi')),
      body: Center(child: Text('Belum ada riwayat.')),
    );
  }
}
