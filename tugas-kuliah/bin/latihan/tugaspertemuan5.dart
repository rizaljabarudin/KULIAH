import 'dart:io';

void main() {
  bool lanjut = true;

  while (lanjut) {
    print("\n=== Kalkulator Sederhana ===");

    stdout.write("Masukkan angka pertama: ");
    double? angka1 = double.tryParse(stdin.readLineSync() ?? '');
    stdout.write("Masukkan angka kedua: ");
    double? angka2 = double.tryParse(stdin.readLineSync() ?? '');

    if (angka1 == null || angka2 == null) {
      print("Input angka tidak valid!");
      continue;
    }

    print("\nPilih operasi yang ingin digunakan:");
    print("1. Penjumlahan");
    print("2. Pengurangan");
    print("3. Perkalian");
    print("4. Pembagian");
    stdout.write("Pilih operasi (1-4): ");
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        print("Hasil penjumlahan = ${angka1 + angka2}");
        break;
      case '2':
        print("Hasil pengurangan = ${angka1 - angka2}");
        break;
      case '3':
        print("Hasil perkalian = ${angka1 * angka2}");
        break;
      case '4':
        if (angka2 != 0) {
          print("Hasil pembagian = ${angka1 / angka2}");
        } else {
          print("Error: Pembagian dengan nol tidak diperbolehkan!");
        }
        break;
      default:
        print("Pilihan tidak valid!");
    }
    stdout.write("\nApakah ingin melanjutkan? (y/n): ");
    String? jawaban = stdin.readLineSync();
    if (jawaban == null || jawaban.toLowerCase() != 'y') {
      lanjut = false;
      print("Program selesai. Terima kasih!");
    }
  }
}