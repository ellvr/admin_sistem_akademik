import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

class KelasPage extends StatelessWidget {
  const KelasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Daftar Kelas', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.lg),
          
          // Filter Section
          _buildFilters(),
          
          const SizedBox(height: AppSpacing.xxl),
          
          // Search Section
          _buildSearchRow(),
          
          const SizedBox(height: AppSpacing.md),
          
          // Table Section
          _buildKelasTable(),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        _filterRow("Fakultas", "Ilmu Komputer"),
        _filterRow("Departemen", "Sistem Informasi"),
        _filterRow("Program Studi", "Sistem Informasi"),
        const SizedBox(height: AppSpacing.md),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 120), // Menyesuaikan label
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.textDisabled),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("Tampilkan"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: AppTextStyles.bodyText)),
          const Text(" : "),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 200,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.textDisabled),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: AppTextStyles.bodyText),
                const Icon(Icons.arrow_drop_down, color: AppColors.textDisabled),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 300,
          height: 35,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.textDisabled),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.textPrimary,
            side: const BorderSide(color: AppColors.textDisabled),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: const Text("Cari"),
        ),
      ],
    );
  }

  Widget _buildKelasTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textDisabled),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5), // Jadwal
          1: FlexColumnWidth(2),   // Nama MK
          2: FlexColumnWidth(1),   // Kode MK
          3: FlexColumnWidth(0.6), // Kelas
          4: FlexColumnWidth(1.5), // Ruang
          5: FlexColumnWidth(2),   // Aksi
        },
        border: TableBorder.all(color: AppColors.textDisabled),
        children: [
          // Header
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
            children: [
              _headerCell("Jadwal"),
              _headerCell("Nama MK"),
              _headerCell("Kode MK"),
              _headerCell("Kelas"),
              _headerCell("Ruang"),
              _headerCell("Aksi"),
            ],
          ),
          // Data Rows
          _dataRow("Senin,\n10:30:00 - 12:10:00", "Perancangan Pengalaman Pengguna", "CSD60711", "A", "Gedung F\nFILKOM - F3.11"),
          _dataRow("Selasa,\n10:30:00 - 12:10:00", "Multimodal Storytelling", "CSD60711", "B", "Gedung F\nFILKOM - F3.11"),
          _dataRow("Rabu,\n10:30:00 - 12:10:00", "Sistem Belajar Mesin", "CSD60711", "E", "Gedung F\nFILKOM - F3.11"),
        ],
      ),
    );
  }

  TableCell _headerCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Center(child: Text(text, style: AppTextStyles.itemTitle)),
      ),
    );
  }

  TableRow _dataRow(String jadwal, String nama, String kode, String kelas, String ruang) {
    return TableRow(
      children: [
        _textCell(jadwal),
        _textCell(nama),
        _textCell(kode),
        _textCell(kelas),
        _textCell(ruang),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _actionButton("Presensi"),
              _actionButton("Pengumuman"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _textCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Text(text, style: AppTextStyles.bodyText),
    );
  }

  Widget _actionButton(String label) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.textDisabled),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontSize: 12)),
    );
  }
}