import 'display_helper.dart';

enum JenisTransaksi { setor, tarik, cekSaldo, tampilInfo }

class Transaksi {
  final String _id;
  final JenisTransaksi jenis;
  final double jumlah;
  final DateTime waktu;
  final bool berhasil;

  Transaksi({
    required String id,
    required this.jenis,
    required this.jumlah,
    required this.berhasil,
  })  : _id = id,
        waktu = DateTime.now();

  String get id => _id;

  String get _label => switch (jenis) {
        JenisTransaksi.setor => 'Setor     ',
        JenisTransaksi.tarik => 'Tarik     ',
        JenisTransaksi.cekSaldo => 'Cek Saldo ',
        JenisTransaksi.tampilInfo => 'Info Akun ',
      };

  String get _waktuFormat {
    String p(int n) => n.toString().padLeft(2, '0');
    return '${p(waktu.day)}/${p(waktu.month)}/${waktu.year} ${p(waktu.hour)}:${p(waktu.minute)}';
  }

  void tampilkan() {
    cetakRiwayat(
      _id.padRight(8),
      _label,
      rupiah(jumlah),
      berhasil ? 'OK   ' : 'GAGAL',
      _waktuFormat,
    );
  }
}
