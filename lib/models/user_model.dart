class UserModel {
  final String nip;
  final String nama;
  final String email;
  final String fakultas;
  final String departemen;
  final String prodi;
  final String jabatan;
  final bool isActive;

  UserModel({
    required this.nip,
    required this.nama,
    required this.email,
    required this.fakultas,
    required this.departemen,
    required this.prodi,
    required this.jabatan,
    this.isActive = true,
  });
}