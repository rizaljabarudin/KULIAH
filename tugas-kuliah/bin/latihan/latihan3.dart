import 'dart:io';

void main() {
    stdout.write("Masukan panjang :");
    print(panjang);
    stdout.write("Masukan lebar :");
    print(lebar);
    String? panjang = stdin.readLineSync();
    print(panjang);
}