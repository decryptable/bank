import 'dart:io';

import 'package:interact_cli/interact_cli.dart';
import 'package:tint/tint.dart';

import 'akun_bank.dart';
import 'akun_giro.dart';
import 'akun_tabungan.dart';
import 'display_helper.dart';
import 'input_helper.dart';
import 'menu_handler.dart';
import 'term_detector.dart';
import 'transaksi.dart';

const String _nim = '251240001657';
const String _nama = 'Ichsan Hafizd Al-Fajry';

const List<String> _opsiMenu = [
  'Buat Akun Tabungan',
  'Buat Akun Giro',
  'Setor Dana',
  'Tarik Dana',
  'Cek Saldo',
  'Info Akun Lengkap',
  'Riwayat Transaksi',
  'Keluar',
];

void _loop(List<AkunBank> daftarAkun, List<Transaksi> riwayat) {
  while (true) {
    print('');
    final idx = bacaMenu('Pilih menu', _opsiMenu);
    print('');

    switch (idx) {
      case 0:
        buatTabungan(daftarAkun);
      case 1:
        buatGiro(daftarAkun);
      case 2:
        prosesSetor(daftarAkun, riwayat);
      case 3:
        prosesTarik(daftarAkun, riwayat);
      case 4:
        cekSaldo(daftarAkun, riwayat);
      case 5:
        infoAkun(daftarAkun);
      case 6:
        riwayatTransaksi(riwayat);
      case 7:
        cetakPesan('info', 'Terima kasih. Sampai jumpa!');
        return;
    }
  }
}

void main() {
  final daftarAkun = <AkunBank>[
    AkunTabungan('TAB-001657', 5000000, 'Ichsan Hafizd Al-Fajry', 3.5),
    AkunGiro('GIR-002024', 20000000, 'PT Mencari Cinta Sejati', 5000000),
  ];
  final riwayat = <Transaksi>[];

  try {
    cetakHeader(
      'SISTEM LAYANAN PERBANKAN',
      'NIM  : $_nim',
      'Nama : $_nama',
    );
    _loop(daftarAkun, riwayat);
  } on SignalException {
    reset();
    print('');
    cetakPesan('info', 'Sesi dihentikan.');
  } catch (e, st) {
    reset();
    final msg = supportsAnsi
        ? '[FATAL] Terjadi kesalahan tak terduga.'.red().bold()
        : '[FATAL] Terjadi kesalahan tak terduga.';
    stderr.writeln('\n  $msg');
    stderr.writeln('  ${e.toString()}');
    if (Platform.environment['BANK_DEBUG'] == '1') {
      stderr.writeln(st.toString());
    }
    exitCode = 1;
  } finally {
    reset();
  }
}
