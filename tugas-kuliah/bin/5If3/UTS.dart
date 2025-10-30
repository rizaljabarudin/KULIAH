import 'dart:io';
import 'dart:math';

abstract class Transportasi {
  String id, nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  double get tarifDasar => _tarifDasar;

  double hitungTarif(int jumlahPenumpang);

  void tampilInfo() {
    print('│ ID Transportasi : $id');
    print('│ Nama             : $nama');
    print('│ Tarif Dasar      : Rp ${_tarifDasar.toStringAsFixed(0)}');
    print('│ Kapasitas        : $kapasitas orang');
  }
}

class Taksi extends Transportasi {
  double jarak;
  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) => tarifDasar * jarak;

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('│ Jarak            : ${jarak.toStringAsFixed(1)} km');
  }
}

class Bus extends Transportasi {
  bool adaWifi;
  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) =>
      tarifDasar * jumlahPenumpang + (adaWifi ? 5000 : 0);

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('│ Ada WiFi         : ${adaWifi ? "Ya" : "Tidak"}');
  }
}

class Pesawat extends Transportasi {
  String kelas;
  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
    : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double faktor = 1.0;
    if (kelas.toLowerCase() == 'bisnis') faktor = 1.5;
    if (kelas.toLowerCase() == 'first') faktor = 2.0;
    return tarifDasar * jumlahPenumpang * faktor;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('│ Kelas            : $kelas');
  }
}

class Pemesanan {
  String idPemesanan, namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(
    this.idPemesanan,
    this.namaPelanggan,
    this.transportasi,
    this.jumlahPenumpang,
    this.totalTarif,
  );

  void cetakStruk() {
    print('\n╔════════════════════════════════════════════════╗');
    print('║              STRUK PEMESANAN                   ║');
    print('╚════════════════════════════════════════════════╝');
    print('│ ID Pemesanan       : $idPemesanan');
    print('│ Nama Pelanggan     : $namaPelanggan');
    transportasi.tampilInfo();
    print('│ Jumlah Penumpang   : $jumlahPenumpang orang');
    print('│ Total Tarif        : Rp ${totalTarif.toStringAsFixed(0)}');
    print('╚════════════════════════════════════════════════╝\n');
  }
}

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  String id = 'P${Random().nextInt(9999).toString().padLeft(4, '0')}';
  double total = t.hitungTarif(jumlahPenumpang);
  return Pemesanan(id, nama, t, jumlahPenumpang, total);
}

void main() {
  List<Pemesanan> daftar = [];

  print('=== SISTEM PEMESANAN TRANSPORTASI TERPADU ===');
  stdout.write('Masukkan nama pelanggan: ');
  String nama = stdin.readLineSync() ?? 'Tanpa Nama';

  print('\nPilih jenis transportasi:');
  print('1. Taksi');
  print('2. Bus');
  print('3. Pesawat');
  stdout.write('Masukkan pilihan (1-3): ');
  int pilihan = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  stdout.write('Masukkan jumlah penumpang: ');
  int jml = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

  Transportasi? t;

  switch (pilihan) {
    case 1:
      t = Taksi('T001', 'Taksi Jakarta', 3000, 4, 10);
      break;
    case 2:
      t = Bus('B001', 'Bus TransJakarta', 2000, 30, true);
      break;
    case 3:
      print('\nPilih kelas penerbangan:');
      print('1. Ekonomi');
      print('2. Bisnis');
      print('3. First Class');
      stdout.write('Masukkan pilihan (1-3): ');
      int pilihKelas = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

      String kelas = 'Ekonomi';
      if (pilihKelas == 2) kelas = 'Bisnis';
      if (pilihKelas == 3) kelas = 'First';

      t = Pesawat('P001', 'Garuda Indonesia', 500000, 150, kelas);
      break;
    default:
      print('Pilihan tidak valid.');
      return;
  }

  var pesanan = buatPemesanan(t, nama, jml);
  daftar.add(pesanan);
  pesanan.cetakStruk();

  stdout.write('Apakah ingin melihat semua riwayat pemesanan? (y/n): ');
  if ((stdin.readLineSync() ?? '').toLowerCase() == 'y') {
    print('\n============== DAFTAR PEMESANAN ==============\n');
    for (var p in daftar) {
      p.cetakStruk();
    }
  }
}
