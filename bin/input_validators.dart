import 'package:interact_cli/interact_cli.dart';

import 'display_helper.dart';

final RegExp reNoRek = RegExp(r'^[A-Z]{2,3}-\d{4,10}$');
final RegExp reNama = RegExp(r"^[a-zA-Z\s'.,-]{3,80}$");

bool Function(String) validatorNoRek() => (raw) {
      if (!reNoRek.hasMatch(raw.trim())) {
        throw ValidationError('Format harus TAB-001657 atau GIR-002024');
      }
      return true;
    };

bool Function(String) validatorNama() => (raw) {
      final v = raw.trim();
      if (v.length < 3 || v.length > 80) {
        throw ValidationError('Nama harus 3-80 karakter');
      }
      if (!reNama.hasMatch(v)) {
        throw ValidationError("Hanya huruf, spasi, dan tanda '. , -");
      }
      return true;
    };

bool Function(String) validatorNominal(double min, double max) => (raw) {
      final clean = raw.trim().replaceAll(RegExp(r'[,_\s]'), '');
      final nilai = double.tryParse(clean);
      if (nilai == null)
        throw ValidationError('Masukkan angka, contoh: 1000000');
      if (nilai < min || nilai > max) {
        throw ValidationError('Harus antara ${rupiah(min)} dan ${rupiah(max)}');
      }
      return true;
    };

bool Function(String) validatorPersen(double min, double max) => (raw) {
      final clean = raw.trim().replaceAll('%', '');
      final nilai = double.tryParse(clean);
      if (nilai == null) throw ValidationError('Masukkan angka, contoh: 3.5');
      if (nilai < min || nilai > max) {
        throw ValidationError('Harus antara $min% dan $max%');
      }
      return true;
    };
