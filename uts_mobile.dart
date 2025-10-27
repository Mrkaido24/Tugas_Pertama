import 'dart:math';

abstract class Transportasi {
  String id;
  String nama;
  double _tarifDasar;
  int kapasitas;

  Transportasi(this.id, this.nama, this._tarifDasar, this.kapasitas); 

  double hitungTarif(int jumlahPenumpang);

  double get tarifDasar => _tarifDasar;

  void tampilInfo() {
    print('ID: $id');
    print('Nama: $nama');
    print('Tarif Dasar: ${tarifDasar.toStringAsFixed(0)}');
    print('Kapasitas: $kapasitas penumpang');
  }
}

class Taksi extends Transportasi {
  int jarak;

  Taksi(String id, String nama, double tarifDasar, int kapasitas, this.jarak)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    return tarifDasar * jarak;
  }

  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Taksi');
    print('Jarak: $jarak km');
    print('--------------------------');
  }
}

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
    print('Ada WiFi: ${adaWifi ? "Ya" : "Tidak"}');
  }
}

class Pesawat extends Transportasi {

  String kelas;

  Pesawat(String id, String nama, double tarifDasar, int kapasitas, this.kelas)
      : super(id, nama, tarifDasar, kapasitas);

  @override
  double hitungTarif(int jumlahPenumpang) {
    double faktor = (kelas == "Bisnis") ? 1.5 : 1.0;
    return tarifDasar * jumlahPenumpang * faktor;
  }
  
  @override
  void tampilInfo() {
    super.tampilInfo();
    print('Jenis: Pesawat');
    print('Kelas: $kelas');
  }
}

class Pemesanan {
  String idPemesanan;
  String namaPelanggan;
  Transportasi transportasi;
  int jumlahPenumpang;
  double totalTarif;

  Pemesanan(this.idPemesanan, this.namaPelanggan, this.transportasi, this.jumlahPenumpang, this.totalTarif);

  void cetakStruk() {
    print('===== Struk Pemesanan =====');
    print('ID Pemesanan: $idPemesanan');
    print('Nama Pelanggan: $namaPelanggan');
    print('Transportasi: ${transportasi.nama}');
    print('Jumlah Penumpang: $jumlahPenumpang');
    print('Total Tarif: ${totalTarif.toStringAsFixed(0)}');
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

Pemesanan buatPemesanan(Transportasi t, String nama, int jumlahPenumpang) {
  double total = t.hitungTarif(jumlahPenumpang);
  String id = 'PNS${Random().nextInt(99999).toString().padLeft(4, '0')}';

  return Pemesanan(id, nama, t, jumlahPenumpang, total);
}

void tampilSemuaPesanan(List<Pemesanan> daftar) {
  for (var p in daftar) {
    p.cetakStruk();
  }
  print('Total Pemesanan: ${daftar.length}');
  print('===========================');
}

void main() {

  Taksi taksi1 = Taksi('TX001', 'Blue Bird', 10000, 4, 15);
  Bus bus1 = Bus('BS001', 'TransJakarta', 5000, 40, true);
  Pesawat pesawat1 = Pesawat('PS001', 'Garuda Indonesia', 200000, 180, 'Ekonomi');

  taksi1.tampilInfo();
  bus1.tampilInfo();  
  pesawat1.tampilInfo();

  var p1 = buatPemesanan(taksi1, 'Andi', 3);
  var p2 = buatPemesanan(bus1, 'Budi', 10);
  var p3 = buatPemesanan(pesawat1, 'Citra', 2);

  List<Pemesanan> daftarPemesanan = [p1, p2, p3];
  tampilSemuaPesanan(daftarPemesanan);
}

