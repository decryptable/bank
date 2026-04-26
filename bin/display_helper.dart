import 'dart:io';

import 'package:tint/tint.dart';

import 'term_detector.dart';

int get _lebar {
  try {
    return stdout.terminalColumns.clamp(40, 120);
  } catch (_) {
    return 80;
  }
}

String _c(String text, String Function(String) style) => styled(text, style);

String rupiah(double nilai) {
  final isNeg = nilai < 0;
  final bagian = nilai.abs().toStringAsFixed(0);
  final buf = StringBuffer();
  int count = 0;
  for (int i = bagian.length - 1; i >= 0; i--) {
    if (count > 0 && count % 3 == 0) buf.write('.');
    buf.write(bagian[i]);
    count++;
  }
  final formatted = buf.toString().split('').reversed.join();
  return 'Rp${isNeg ? '-' : ''}$formatted';
}

void cetakHeader(String baris1, String baris2, String baris3) {
  final lebar = _lebar;
  final dalam = lebar - 2;
  String pad(String s) => '|${s.padRight(dalam)}|';
  print(_c('+${'=' * dalam}+', (s) => s.cyan().bold()));
  print(_c(pad(' $baris1'), (s) => s.cyan().bold()));
  print(_c(pad(' $baris2'), (s) => s.cyan()));
  print(_c(pad(' $baris3'), (s) => s.cyan()));
  print(_c('+${'=' * dalam}+', (s) => s.cyan().bold()));
}

void cetakBaris(String label, String nilai, {bool highlight = false}) {
  final labelPad = label.padRight(22);
  final baris = '  $labelPad: $nilai';
  print(highlight ? _c(baris, (s) => s.bold()) : baris);
}

void cetakPesan(String tipe, String pesan) {
  final (prefix, fn) = switch (tipe) {
    'ok' => ('[OK]  ', (String s) => s.green()),
    'err' => ('[ERR] ', (String s) => s.red().bold()),
    'info' => ('[INF] ', (String s) => s.yellow()),
    _ => ('[?]   ', (String s) => s),
  };
  print('  ${_c(prefix + pesan, fn)}');
}

void cetakRiwayat(
    String id, String label, String nominal, String status, String waktu) {
  final lebar = _lebar;
  final kiri = '  $id  $label';
  final kanan = '$nominal  $status  $waktu';
  final spasi = (lebar - kiri.length - kanan.length).clamp(1, lebar);
  final statusStyled = status.trim() == 'OK'
      ? _c(status, (s) => s.green())
      : _c(status, (s) => s.red());
  print('$kiri${' ' * spasi}$nominal  $statusStyled  $waktu');
}

void cetakGaris() {
  print(_c('-' * _lebar, (s) => s.dim()));
}
