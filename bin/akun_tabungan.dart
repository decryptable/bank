import 'akun_bank.dart';
import 'display_helper.dart';

class AkunTabungan extends AkunBank {
  double _bungaTahunanPersen;

  AkunTabungan(
    String nomorRekening,
    double saldoAwal,
    String namaNasabah,
    double bungaTahunanPersen,
  )   : _bungaTahunanPersen = bungaTahunanPersen,
        super(nomorRekening, saldoAwal, namaNasabah);

  double get bungaTahunanPersen => _bungaTahunanPersen;

  set bungaTahunanPersen(double nilai) {
    if (nilai < 0 || nilai > 20) {
      throw ArgumentError('Bunga harus antara 0% dan 20%.');
    }
    _bungaTahunanPersen = nilai;
  }

  double hitungBungaBulanan() {
    return saldo * (_bungaTahunanPersen / 100) / 12;
  }

  @override
  void tampilkanInfo() {
    cetakBaris('Jenis', 'Tabungan');
    super.tampilkanInfo();
    cetakBaris('Bunga/Tahun', '$_bungaTahunanPersen%');
    cetakBaris('Est. Bunga Bulan', rupiah(hitungBungaBulanan()));
  }
}
