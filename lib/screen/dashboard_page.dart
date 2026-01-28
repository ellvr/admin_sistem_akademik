import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<Map<String, dynamic>> classes = const [
    {
      "jadwal": "Senin\n10:30 - 12:10",
      "mk": "Perancangan Pengalaman Pengguna",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": 3,
      "jam": 1.5,
    },
    {
      "jadwal": "Selasa\n10:30 - 12:10",
      "mk": "Multimodal Storytelling",
      "kode": "CSD60712",
      "kelas": "B",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": 2,
      "jam": 1.5,
    },
    {
      "jadwal": "Rabu\n10:30 - 12:10",
      "mk": "Sistem Belajar Mesin",
      "kode": "CSD60713",
      "kelas": "E",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": 4,
      "jam": 1.5,
    },
    {
      "jadwal": "Kamis\n10:30 - 12:10",
      "mk": "Multimodal Storytelling",
      "kode": "CSD60714",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": 2,
      "jam": 1.5,
    },
    {
      "jadwal": "Jum’at\n10:30 - 12:10",
      "mk": "Sistem Belajar Mesin",
      "kode": "CSD60715",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": 4,
      "jam": 1.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int totalKelas = classes.length;
    int totalSKS = classes.fold<int>(0, (sum, c) => sum + (c["sks"] as int));
    double totalJam = classes.fold<double>(
      0,
      (sum, c) => sum + (c["jam"] as double),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _profileCard(totalKelas, totalJam, totalSKS),
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(flex: 2, child: _upcomingClass()),
        ],
      ),
    );
  }

  Widget _profileCard(int totalKelas, double totalJam, int totalSKS) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB2E2F1)),
              color: Color(0xFFE6F6FB),
            ),
            child: const Icon(Icons.person, size: 80, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          _info("Nama", UserSession.nama),
          _info("NIP", UserSession.nip),
          _info("Email", UserSession.email),
          _info("Fakultas", UserSession.fakultas),
          _info("Departemen", UserSession.departemen),
          _info("Status", UserSession.status, isStatus: true),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatBox(label: "Kelas", value: totalKelas.toString()),
              _StatBox(label: "Jam", value: totalJam.toString()),
              _StatBox(label: "SKS", value: totalSKS.toString()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          const Text(" : "),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isStatus ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingClass() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Upcoming Class", style: AppTextStyles.sectionTitle),
          const SizedBox(height: 16),
          _tableHeader(),
          ...classes.map(
            (c) => _row(
              c["jadwal"],
              c["mk"],
              c["kode"],
              c["kelas"],
              c["ruang"],
              c["sks"].toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: const BoxDecoration(color: Color(0xFFDAF1F8)),
      child: Row(
        children: const [
          Expanded(
            flex: 2,
            child: Text(
              "Jadwal",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Nama MK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "Kode MK",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Kelas",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text("Ruang", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Center(
              child: Text("SKS", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    String jadwal,
    String mk,
    String kode,
    String kelas,
    String ruang,
    String sks,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(jadwal)),
          Expanded(flex: 3, child: Text(mk)),
          Expanded(child: Text(kode)),
          Expanded(child: Center(child: Text(kelas))),
          Expanded(flex: 2, child: Text(ruang)),
          Expanded(child: Center(child: Text(sks))),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
    );
  }
}

class UserSession {
  static String nama = "Elvira Rosa";
  static String email = "elvira@admin.ub.ac.id";
  static String nip = "235150600111006";
  static String fakultas = "Ilmu Komputer";
  static String departemen = "Sistem Informasi";
  static String status = "Aktif";
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
