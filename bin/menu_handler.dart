import 'akun_bank.dart';
import 'akun_giro.dart';
import 'akun_tabungan.dart';
import 'display_helper.dart';
import 'input_helper.dart';
import 'transaksi.dart';

AkunBank? cariAkun(List<AkunBank> daftar, String noRek) {
  try {
    return daftar.firstWhere((a) => a.nomorRekening == noRek);
  } catch (_) {
    return null;
  }
}

void buatTabungan(List<AkunBank> daftar) {
  final noRek = bacaNoRekening('No. Rekening');
  if (daftar.any((a) => a.nomorRekening == noRek)) {
    cetakPesan('err', 'No. rekening $noRek sudah terdaftar.');
    return;
  }
  final nama = bacaNama('Nama Nasabah');
  final saldo = bacaNominal('Saldo Awal', min: 0, max: 100000000);
  final bunga = bacaPersen('Bunga per Tahun', min: 0, max: 20);
  if (nama == null || saldo == null || bunga == null) return;
  daftar.add(AkunTabungan(noRek, saldo, nama, bunga));
  cetakPesan('ok', 'Akun tabungan $noRek berhasil dibuat.');
}

void buatGiro(List<AkunBank> daftar) {
  final noRek = bacaNoRekening('No. Rekening');
  if (daftar.any((a) => a.nomorRekening == noRek)) {
    cetakPesan('err', 'No. rekening $noRek sudah terdaftar.');
    return;
  }
  final nama = bacaNama('Nama Nasabah');
  final saldo = bacaNominal('Saldo Awal', min: 0, max: 500000000);
  final limit = bacaNominal('Limit Overdraft', min: 0, max: 50000000);
  if (nama == null || saldo == null || limit == null) return;
  daftar.add(AkunGiro(noRek, saldo, nama, limit));
  cetakPesan('ok', 'Akun giro $noRek berhasil dibuat.');
}

void prosesSetor(List<AkunBank> daftar, List<Transaksi> log) {
  final noRek = bacaNoRekening('No. Rekening');
  final akun = cariAkun(daftar, noRek);
  if (akun == null) {
    cetakPesan('err', 'Akun tidak ditemukan.');
    return;
  }
  final jumlah = bacaNominal('Jumlah Setor', min: 10000, max: 100000000);
  if (jumlah == null) return;
  final ok = akun.setor(jumlah);
  log.add(Transaksi(
      id: 'TRX${(log.length + 1).toString().padLeft(4, '0')}',
      jenis: JenisTransaksi.setor,
      jumlah: jumlah,
      berhasil: ok));
  ok
      ? cetakPesan('ok', 'Setoran berhasil. Saldo: ${rupiah(akun.saldo)}')
      : cetakPesan('err', 'Setoran gagal.');
}

void prosesTarik(List<AkunBank> daftar, List<Transaksi> log) {
  final noRek = bacaNoRekening('No. Rekening');
  final akun = cariAkun(daftar, noRek);
  if (akun == null) {
    cetakPesan('err', 'Akun tidak ditemukan.');
    return;
  }
  final jumlah = bacaNominal('Jumlah Tarik', min: 50000, max: 100000000);
  if (jumlah == null) return;
  final ok = akun.tarik(jumlah);
  log.add(Transaksi(
      id: 'TRX${(log.length + 1).toString().padLeft(4, '0')}',
      jenis: JenisTransaksi.tarik,
      jumlah: jumlah,
      berhasil: ok));
  ok
      ? cetakPesan('ok', 'Penarikan berhasil. Saldo: ${rupiah(akun.saldo)}')
      : cetakPesan('err', 'Saldo tidak mencukupi atau nominal tidak valid.');
}

void cekSaldo(List<AkunBank> daftar, List<Transaksi> log) {
  final noRek = bacaNoRekening('No. Rekening');
  final akun = cariAkun(daftar, noRek);
  if (akun == null) {
    cetakPesan('err', 'Akun tidak ditemukan.');
    return;
  }
  cetakPesan('info', 'Saldo saat ini: ${rupiah(akun.saldo)}');
  log.add(Transaksi(
      id: 'TRX${(log.length + 1).toString().padLeft(4, '0')}',
      jenis: JenisTransaksi.cekSaldo,
      jumlah: akun.saldo,
      berhasil: true));
}

void infoAkun(List<AkunBank> daftar) {
  final noRek = bacaNoRekening('No. Rekening');
  final akun = cariAkun(daftar, noRek);
  if (akun == null) {
    cetakPesan('err', 'Akun tidak ditemukan.');
    return;
  }
  print('');
  akun.tampilkanInfo();
}

void riwayatTransaksi(List<Transaksi> log) {
  if (log.isEmpty) {
    cetakPesan('info', 'Belum ada riwayat transaksi.');
    return;
  }
  cetakGaris();
  for (final t in log) {
    t.tampilkan();
  }
  cetakGaris();
}
