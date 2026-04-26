import 'dart:io';

import 'package:interact_cli/interact_cli.dart';
import 'package:tint/tint.dart';

import 'display_helper.dart';
import 'input_fallback.dart';
import 'input_validators.dart';
import 'term_detector.dart';

const _erase = '\x1B[1A\x1B[2K';

String _erased(String val) {
  if (supportsAnsi) stdout.write(_erase);
  return val;
}

String _h(String t) => supportsAnsi ? t.dim() : '($t)';
String _l(String t) => supportsAnsi ? t.cyan() : t;

String _inp(String prompt, bool Function(String) validator) =>
    _erased(Input(prompt: _l(prompt), validator: validator).interact().trim());

String bacaNoRekening(String prompt) {
  if (supportsInteractive) return _inp(prompt, validatorNoRek());
  return fallbackLoop(
      prompt, validatorNoRek(), 'Format salah. Contoh: TAB-001657');
}

String? bacaNama(String prompt) {
  if (supportsInteractive) return _inp(prompt, validatorNama());
  stdout.write('$prompt ${_h("3-80 huruf")}: ');
  final raw = stdin.readLineSync()?.trim() ?? '';
  try {
    validatorNama()(raw);
    return raw;
  } catch (e) {
    stderr.writeln(supportsAnsi
        ? '[ERR] Nama tidak valid.'.red().bold()
        : '[ERR] Nama tidak valid.');
    return null;
  }
}

double? bacaNominal(String prompt, {required double min, required double max}) {
  final hint = _h('${rupiah(min)}-${rupiah(max)}');
  if (supportsInteractive) {
    final raw = _inp('$prompt $hint', validatorNominal(min, max))
        .replaceAll(RegExp(r'[,_\s]'), '');
    return double.tryParse(raw);
  }
  return fallbackNominal(prompt, hint, min, max);
}

double? bacaPersen(String prompt, {required double min, required double max}) {
  final hint = _h('$min%-$max%');
  if (supportsInteractive) {
    final raw =
        _inp('$prompt $hint', validatorPersen(min, max)).replaceAll('%', '');
    return double.tryParse(raw);
  }
  return fallbackPersen(prompt, hint, min, max);
}

int bacaMenu(String prompt, List<String> opsi) {
  if (supportsInteractive) {
    final idx = Select(prompt: _l(prompt), options: opsi).interact();
    if (supportsAnsi) stdout.write(_erase);
    return idx;
  }
  return fallbackMenu(prompt, opsi);
}

bool bacaKonfirmasi(String prompt) {
  if (supportsInteractive) {
    final val = Confirm(prompt: _l(prompt), defaultValue: false).interact();
    if (supportsAnsi) stdout.write(_erase);
    return val;
  }
  stdout.write('$prompt (y/N): ');
  final raw = stdin.readLineSync()?.trim().toLowerCase() ?? '';
  return raw == 'y' || raw == 'ya';
}
