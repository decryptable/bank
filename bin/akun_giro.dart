import 'akun_bank.dart';
import 'display_helper.dart';

class AkunGiro extends AkunBank {
  final double _limitOverdraft;

  AkunGiro(
    String nomorRekening,
    double saldoAwal,
    String namaNasabah,
    double limitOverdraft,
  )   : _limitOverdraft = limitOverdraft,
        super(nomorRekening, saldoAwal, namaNasabah);

  double get limitOverdraft => _limitOverdraft;
  double get dayaTarikMaksimum => saldo + _limitOverdraft;

  @override
  bool tarik(double jumlah) {
    if (jumlah <= 0 || jumlah > 500000000) return false;
    if (jumlah > dayaTarikMaksimum) return false;
    saldo = saldo - jumlah;
    return true;
  }

  @override
  void tampilkanInfo() {
    cetakBaris('Jenis', 'Giro');
    super.tampilkanInfo();
    cetakBaris('Limit Overdraft', rupiah(_limitOverdraft));
    cetakBaris('Maks. Penarikan', rupiah(dayaTarikMaksimum));
  }
}
