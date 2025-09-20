void main () {

  String nama = 'Fadel';
  int jamKerja = 8;
  double upahPerJam = 20000;
  bool statusKaryawan = true;

  double gajiKotor =  jamKerja * upahPerJam;
  
  double pajak(double gajiKotor, bool statusKaryawan) {
    if (statusKaryawan) {
      return gajiKotor * 0.10;
    } else {
      return gajiKotor * 0.05;
    }
  }

  var gajiBersih = gajiKotor - pajak(gajiKotor, statusKaryawan);

  print('Nama Karyawan : $nama');
  print('Jam Kerja : $jamKerja');
  print('Upah Per Jam : $upahPerJam');
  print('Status Karyawan : $statusKaryawan');
  print('Gaji Kotor : $gajiKotor');
  print('Pajak : ${pajak(gajiKotor, statusKaryawan)}');
  print('Gaji Bersih : $gajiBersih');

}