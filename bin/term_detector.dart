import 'dart:io';

import 'package:cli_util/cli_logging.dart';

final Ansi _ansi = Ansi(Ansi.terminalSupportsAnsi);

bool get supportsAnsi => _ansi.useAnsi;

bool get supportsInteractive {
  if (!stdin.hasTerminal) return false;
  if (Platform.isWindows) {
    final term = Platform.environment['WT_SESSION'];
    final conemu = Platform.environment['ConEmuANSI'];
    if (term == null && conemu == null && !supportsAnsi) return false;
  }
  return true;
}

String styled(String text, String Function(String) style) {
  return supportsAnsi ? style(text) : text;
}
