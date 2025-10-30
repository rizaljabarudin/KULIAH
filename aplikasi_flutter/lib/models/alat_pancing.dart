class AlatPancing {
  final String id;
  final String nama;
  final String deskripsi;
  final double harga;
  final String gambarUrl;

  AlatPancing({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambarUrl,
  });

  // Konversi dari Map (Firestore)
  factory AlatPancing.fromMap(Map<String, dynamic> data, String documentId) {
    return AlatPancing(
      id: documentId,
      nama: data['nama'] ?? '',
      deskripsi: data['deskripsi'] ?? '',
      harga: (data['harga'] is int)
          ? (data['harga'] as int).toDouble()
          : (data['harga'] ?? 0.0).toDouble(),
      gambarUrl: data['gambarUrl'] ?? '',
    );
  }

  // Konversi ke Map (untuk simpan ke Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'deskripsi': deskripsi,
      'harga': harga,
      'gambarUrl': gambarUrl,
    };
  }
}
