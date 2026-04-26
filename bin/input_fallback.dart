import 'dart:io';

import 'package:interact_cli/interact_cli.dart';
import 'package:tint/tint.dart';

import 'term_detector.dart';

String _e(String t) => supportsAnsi ? t.red().bold() : '[ERR] $t';

String fallbackLoop(
    String prompt, bool Function(String) validator, String hint) {
  while (true) {
    stdout.write('$prompt: ');
    final raw = stdin.readLineSync()?.trim() ?? '';
    try {
      validator(raw);
      return raw;
    } catch (e) {
      print(_e(e is ValidationError ? e.message : hint));
    }
  }
}

double? fallbackNominal(String prompt, String hint, double min, double max) {
  stdout.write('$prompt $hint: ');
  final raw =
      stdin.readLineSync()?.trim().replaceAll(RegExp(r'[,_\s]'), '') ?? '';
  final nilai = double.tryParse(raw);
  if (nilai == null || nilai < min || nilai > max) {
    print(_e('Nominal tidak valid.'));
    return null;
  }
  return nilai;
}

double? fallbackPersen(String prompt, String hint, double min, double max) {
  stdout.write('$prompt $hint: ');
  final raw = stdin.readLineSync()?.trim().replaceAll('%', '') ?? '';
  final nilai = double.tryParse(raw);
  if (nilai == null || nilai < min || nilai > max) {
    print(_e('Persen tidak valid.'));
    return null;
  }
  return nilai;
}

int fallbackMenu(String prompt, List<String> opsi) {
  print('\n$prompt');
  for (var i = 0; i < opsi.length; i++) {
    print('  ${i + 1}. ${opsi[i]}');
  }
  while (true) {
    stdout.write('  Pilihan (1-${opsi.length}): ');
    final raw = stdin.readLineSync()?.trim() ?? '';
    final nilai = int.tryParse(raw);
    if (nilai != null && nilai >= 1 && nilai <= opsi.length) return nilai - 1;
    print(_e('Masukkan angka 1-${opsi.length}.'));
  }
}
