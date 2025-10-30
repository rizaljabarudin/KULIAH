// program_sederhana_extends.dart
// Bahasa pemrograman: Dart

class Dosen {
  String? nama;
  int? npm;
}

class Mahasiswa extends Dosen {}

void main() {
  Dosen dosen = Dosen();
  dosen.nama = 'Budi';
  dosen.npm = 987654;

  Mahasiswa mhs = Mahasiswa();
  mhs.nama = 'Rizal';
  mhs.npm = 123456;

  print('Dosen: ${dosen.nama}, NPM: ${dosen.npm}');
  print('Mahasiswa: ${mhs.nama}, NPM: ${mhs.npm}');
}
