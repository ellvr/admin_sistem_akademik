class Mahasiswa {
  final String nim;
  final String nama;
  String status; // Hadir, Alfa, Izin, Sakit
  final Map<String, int> rekap;
  final String persen;

  Mahasiswa({
    required this.nim,
    required this.nama,
    required this.status,
    required this.rekap,
    required this.persen,
  });

  // Untuk konversi dari Firebase/API
  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      nim: json['nim'],
      nama: json['nama'],
      status: json['status'],
      rekap: Map<String, int>.from(json['rekap']),
      persen: json['persen'],
    );
  }
}