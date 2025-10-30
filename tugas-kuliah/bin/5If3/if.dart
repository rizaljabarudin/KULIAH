import 'dart:io';

void main() {
  // Minta input nilai dari user
  stdout.write("Cek nilai mahasiswa: ");
  int nilai = int.parse(stdin.readLineSync()!);

  // Mengevaluasi nilai dengan if-else
  if (nilai >= 90) {
    print("Nilai: A");
  } else if (nilai >= 80) {
    print("Nilai: B");
  } else if (nilai >= 70) {
    print("Nilai: AB");
  } else if (nilai >= 60) {
    print("Nilai: C");
  } else if (nilai >= 50) {
    print("Nilai: D");
  } else {
    print("Nilai: E (Tidak Lulus)");
  }
}
