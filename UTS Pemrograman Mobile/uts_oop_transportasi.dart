// Program: Sistem Pemesanan Transportasi Terpadu
// Bahasa: Dart
// Konsep: OOP (class, inheritance, encapsulation, polymorphism, function)

import 'dart:math';

// ==========================
// Kelas Abstrak Transportasi
// ==========================
abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas);

  // Getter untuk _tarifDasar (enkapsulasi)
  double get tarifDasar => _tarifDasar;

  // Method abstrak (harus diimplementasikan oleh turunan)
  double hitungTarif(int jumlahPenumpang);

  // Menampilkan info transportasi
  void tampilInfo() {
    print('ID: $id');
    print('Nama: $nama');
    print('Tarif Dasar: Rp${_tarifDasar.toStringAsFixed(0)}');
    print('Kapasitas: $kapasitas orang');
  }
}

// ==========================
// Kelas Turunan: Taksi
// ==========================
class Taksi extends Transportasi {
  double jarak; // km

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    // Tarif tidak tergantung jumlah penumpang, hanya jarak
    return tarifDasar * jarak;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Taksi');
    print('Jarak: $jarak km');
    print('----------------------------');
  }
}

// ==========================
// Kelas Turunan: Bus
// ==========================
class Bus extends Transportasi {
  bool adaWifi;

  Bus(String id, String nama, double tarifDasar, int kapasitas, this.adaWifi)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double total = (tarifDasar * jumlahPenumpang) + (adaWifi ? 5000 : 0);
    return total;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Bus');
    print('Ada Wifi: ${adaWifi ? "Ya" : "Tidak"}');
    print('----------------------------');
  }
}

// ==========================
// Kelas Turunan: Pesawat
// ==========================
class Pesawat extends Transportasi {
  String kelasPenerbangan; // Ekonomi atau Bisnis

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelasPenerbangan)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double faktor = (kelasPenerbangan == "Bisnis") ? 1.5 : 1.0;
    return tarifDasar * jumlahPenumpang * faktor;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Pesawat');
    print('Kelas: $kelasPenerbangan');
    print('----------------------------');
  }
}

// ==========================
// Kelas Pemesanan
// ==========================
class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi,
      this.jumlahPenumpang, this.totalTarif);

  void cetakStruk() {
    print('===== STRUK PEMESANAN =====');
    print('Kode Pemesanan: $idPemesanan');
    print('Nama Pelanggan: $namaPelanggan');
    print('Transportasi: ${transportasi.nama}');
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Tarif: Rp${totalTarif.toStringAsFixed(0)}');
    print('============================\n');
  }

  Map<String, dynamic> toMap() {
    return {
      'idPemesanan': idPemesanan,
      'namaPelanggan': namaPelanggan,
      'transportasi': transportasi.nama,
      'jumlahPenumpang': jumlahPenumpang,
      'totalTarif': totalTarif,
    };
  }
}

// ==========================
// Fungsi Global
// ==========================
Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  String id = 'PSN${Random().nextInt(9999).toString().padLeft(4, '0')}';

  return Pemesanan(id, nama, t, jumlahPenumpang, total);
}

void tampilSemuaPemesanan(List<Pemesanan> daftar) {
  print('===== DAFTAR PEMESANAN =====');
  for (var p in daftar) {
    p.cetakStruk();
  }
  print('Total Pemesanan: ${daftar.length}');
  print('============================');
}

// ==========================
// Fungsi main()
// ==========================
void main() {
  // Membuat objek transportasi
  Taksi taksi1 = Taksi('TX001', 'Blue Bird', 8000, 4, 12);
  Bus bus1 = Bus('BS001', 'TransJakarta', 3000, 40, true);
  Pesawat pesawat1 = Pesawat('PS001', 'Garuda Indonesia', 1500000, 180, 'Bisnis');

  // Menampilkan info transportasi
  taksi1.tampilInfo();
  bus1.tampilInfo();
  pesawat1.tampilInfo();

  // Membuat beberapa pemesanan
  var p1 = buatPemesanan(taksi1, 'Andi', 2);
  var p2 = buatPemesanan(bus1, 'Budi', 10);
  var p3 = buatPemesanan(pesawat1, 'Citra', 2);

  // Simpan semua pemesanan
  List<Pemesanan> daftarPemesanan = [p1, p2, p3];

  // Tampilkan semua hasil transaksi
  tampilSemuaPemesanan(daftarPemesanan);
}