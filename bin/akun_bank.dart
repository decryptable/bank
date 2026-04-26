import 'display_helper.dart';

class AkunBank {
  final String _nomorRekening;
  double _saldo;
  final String namaNasabah;

  AkunBank(this._nomorRekening, double saldoAwal, this.namaNasabah)
      : _saldo = saldoAwal;

  String get nomorRekening => _nomorRekening;
  double get saldo => _saldo;

  set saldo(double nilai) {
    if (nilai < -50000000) {
      throw ArgumentError('Saldo melampaui batas minimum yang diizinkan.');
    }
    _saldo = nilai;
  }

  bool setor(double jumlah) {
    if (jumlah <= 0 || jumlah > 100000000) return false;
    _saldo += jumlah;
    return true;
  }

  bool tarik(double jumlah) {
    if (jumlah <= 0 || jumlah > 100000000) return false;
    if (jumlah > _saldo) return false;
    _saldo -= jumlah;
    return true;
  }

  void tampilkanInfo() {
    cetakBaris('No. Rekening', _nomorRekening);
    cetakBaris('Nasabah', namaNasabah);
    cetakBaris('Saldo', rupiah(_saldo));
  }
}
