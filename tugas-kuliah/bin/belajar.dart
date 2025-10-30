class Mobil {
  String? merk;
  String? warna;
  int? tahun;
  int? harga;

  
  void info() {
    print("=== Informasi Mobil ===");
    print("Merk  : $merk");
    print("Warna : $warna");
    print("Tahun : $tahun");
    print("Harga : Rp$harga");
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
