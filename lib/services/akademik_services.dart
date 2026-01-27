import '../models/akademik_model.dart';

class AkademikService {
  Future<List<KelasModel>> getDaftarKelas() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi delay
    return [
      KelasModel(jadwal: "Senin,\n10:30:00 - 12:10:00", nama: "Perancangan Pengalaman Pengguna", kode: "CSD60711", kelas: "A", ruang: "Gedung F\nFILKOM - F3.11", prodi: "Sistem Informasi"),
      KelasModel(jadwal: "Selasa,\n10:30:00 - 12:10:00", nama: "Multimodal Storytelling", kode: "CSD60711", kelas: "B", ruang: "Gedung F\nFILKOM - F3.11", prodi: "Sistem Informasi"),
      KelasModel(jadwal: "Rabu,\n10:30:00 - 12:10:00", nama: "Sistem Belajar Mesin", kode: "CSD60711", kelas: "E", ruang: "Gedung F\nFILKOM - F3.11", prodi: "Sistem Informasi"),
      KelasModel(jadwal: "Kamis,\n10:30:00 - 12:10:00", nama: "Interaksi Manusia Komputer", kode: "CSD60711", kelas: "A", ruang: "Gedung F\nFILKOM - F3.11", prodi: "Pendidikan TI"),
      KelasModel(jadwal: "Jum'at,\n10:30:00 - 12:10:00", nama: "Data Mining", kode: "CSD60711", kelas: "A", ruang: "Gedung F\nFILKOM - F3.11", prodi: "Sistem Informasi"),
    ];
  }
}