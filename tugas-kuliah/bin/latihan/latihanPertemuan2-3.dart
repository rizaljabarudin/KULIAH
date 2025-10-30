import 'dart:io';

void main(List<String> args) {
  // Map untuk menyimpan username dan password
  Map<String, dynamic> user = {
    'admin': 'admin',
    'user': 'user',
    'guest': 'guest',
  };

  // Menampilkan semua user yang tersedia (opsional)
  print('Daftar user yang tersedia:');
  user.forEach((key, value) {
    print('- $key');
  });

  // Input dari pengguna
  stdout.write('Masukkan username: ');
  String? name = stdin.readLineSync();

  stdout.write('Masukkan password: ');
  String? password = stdin.readLineSync();

  // Cek apakah username ada dan password-nya cocok
  if (user.containsKey(name) && user[name] == password) {
    print('\nLogin berhasil! Selamat datang, $name 👋');
  } else {
    print('\nLogin gagal! Username atau password salah ❌');
  }
}
