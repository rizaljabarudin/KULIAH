import 'dart:io';

void main() {
  // Minta input panjang
  stdout.write("Masukkan panjang: ");
  String? panjangInput = stdin.readLineSync();
  
  // Minta input lebar
  stdout.write("Masukkan lebar: ");
  String? lebarInput = stdin.readLineSync();
  
  // Tampilkan hasil input
  print("Panjang: $panjangInput");
  print("Lebar  : $lebarInput");
}
