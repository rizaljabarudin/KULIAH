import 'dart:io';

int perkalian(int a, int b) {
  return a * b;
}

void main() {
  print("Masukkan angka pertama:");
  String? input1 = stdin.readLineSync();
  int angka1 = int.parse(input1!);

  print("Masukkan angka kedua:");
  String? input2 = stdin.readLineSync();
  int angka2 = int.parse(input2!);

  int hasil = perkalian(angka1, angka2);
  print("Hasil perkalian dari $angka1 x $angka2 = $hasil");
}