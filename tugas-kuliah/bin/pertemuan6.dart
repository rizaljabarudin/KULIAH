class Mobil {
  String? merk;
  String? warna;
  int? tahun;
  int? harga;

  
  Mobil({this.merk, this.warna, this.tahun, this.harga});

  
  void info() {
    print("Merk: $merk");
    print("Warna: $warna");
    print("Tahun: $tahun");
    print("Harga: Rp$harga");
  }
}

void main() {
  Mobil mobil = Mobil();

  mobil.merk = "Toyota";
  mobil.warna = "Hitam";
  mobil.tahun = 2000;
  mobil.harga = 120000000;

  mobil.info();
}
