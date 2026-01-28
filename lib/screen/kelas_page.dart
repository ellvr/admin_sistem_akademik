// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';
import 'detail_kelas_page.dart';

class KelasPage extends StatefulWidget {
  const KelasPage({super.key});

  @override
  State<KelasPage> createState() => _KelasPageState();
}

class _KelasPageState extends State<KelasPage> {
  bool _showDetail = false;
  Map<String, String>? _selectedKelas;

  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pengumumanController = TextEditingController();

  final List<Map<String, String>> allData = [
    {
      "hari": "Senin",
      "jam": "10:30 - 12:10",
      "nama": "Perancangan Pengalaman Pengguna",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": "3",
    },
    {
      "hari": "Selasa",
      "jam": "10:30 - 12:10",
      "nama": "Multimodal Storytelling",
      "kode": "CSD60712",
      "kelas": "B",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": "2",
    },
    {
      "hari": "Rabu",
      "jam": "10:30 - 12:10",
      "nama": "Sistem Belajar Mesin",
      "kode": "CSD60713",
      "kelas": "E",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": "4",
    },
    {
      "hari": "Kamis",
      "jam": "10:30 - 12:10",
      "nama": "Multimodal Storytelling",
      "kode": "CSD60714",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": "2",
    },
    {
      "hari": "Jum’at",
      "jam": "10:30 - 12:10",
      "nama": "Sistem Belajar Mesin",
      "kode": "CSD60715",
      "kelas": "A",
      "ruang": "Gedung F FIKOM – F3.11",
      "sks": "4",
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (_showDetail && _selectedKelas != null) {
      return DetailKelasPage(
        data: _selectedKelas!,
        onBack: () => setState(() => _showDetail = false),
      );
    }

    final filteredData = allData.where((e) {
      final name = e['nama']!.toLowerCase();
      final code = e['kode']!.toLowerCase();
      return name.contains(searchQuery) || code.contains(searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daftar Kelas', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _infoRow("Fakultas", "Ilmu Komputer"),
            _infoRow("Departemen", "Sistem Informasi"),
            _infoRow("Program Studi", "Magister Sistem Informasi"),

            const SizedBox(height: AppSpacing.xxl),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .04),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [_buildSearchBox()],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: _buildTable(filteredData),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Row(
      children: [
        SizedBox(
          width: 250,
          height: 38,
          child: TextField(
            controller: _searchController,
            onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
            cursorColor: AppColors.primary,
            decoration: const InputDecoration(
              hintText: "Cari mata kuliah...",
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
              fillColor: AppColors.background,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightActive),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          height: 38,
          child: ElevatedButton(
            onPressed: () => setState(
              () => searchQuery = _searchController.text.toLowerCase(),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text("Cari", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _buildTable(List<Map<String, String>> data) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(2.6),
        2: FlexColumnWidth(0.7),
        3: FlexColumnWidth(1.2),
        4: FlexColumnWidth(0.7),
        5: FlexColumnWidth(1.5),
        6: FlexColumnWidth(2.6),
      },
      border: TableBorder.all(color: Colors.grey.withValues(alpha: .2)),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xffDAF1F8)),
          children: [
            _cell("Jadwal", true),
            _cell("Nama MK", true),
            _cell("SKS", true, TextAlign.center),
            _cell("Kode MK", true),
            _cell("Kelas", true, TextAlign.center),
            _cell("Ruang", true),
            _cell("Aksi", true, TextAlign.center),
          ],
        ),
        ...data.map((e) {
          return TableRow(
            children: [
              InkWell(onTap: () => _openDetail(e), child: _jadwalCell(e)),
              _tapCell(e, e['nama']!),
              _tapCell(e, e['sks']!, align: TextAlign.center),
              _tapCell(e, e['kode']!),
              _tapCell(e, e['kelas']!, align: TextAlign.center),
              _tapCell(e, e['ruang']!),
              _actionCell(e),
            ],
          );
        }),
      ],
    );
  }

  Widget _tapCell(
    Map<String, String> data,
    String text, {
    TextAlign align = TextAlign.start,
  }) {
    return InkWell(
      onTap: () => _openDetail(data),
      child: _cell(text, false, align),
    );
  }

  Widget _jadwalCell(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['hari']!, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(data['jam']!, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _cell(String text, bool header, [TextAlign align = TextAlign.start]) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: header ? 14 : 13,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _actionCell(Map<String, String> data) {
    return SizedBox(
      height: 64,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _miniBtn(
              "Presensi",
              AppColors.primary,
              () => _showPresensiModal(data),
            ),
            const SizedBox(width: 6),
            _miniBtn("Pengumuman", Colors.orange, _showPengumumanModal),
            const SizedBox(width: 6),
            _miniBtn("Lihat", AppColors.textDisabled, () => _openDetail(data)),
          ],
        ),
      ),
    );
  }

  Widget _miniBtn(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: .6)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ),
    );
  }

  void _openDetail(Map<String, String> data) {
    setState(() {
      _selectedKelas = data;
      _showDetail = true;
    });
  }

  void _showPengumumanModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: Text(
            "Pengumuman Kelas",
            style: AppTextStyles.itemTitle.copyWith(color: AppColors.primary),
          ),
          content: Container(
            width: 420,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.lightActive),
            ),
            child: TextField(
              controller: _pengumumanController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Tuliskan pengumuman untuk mata kuliah ini...",
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
              ),
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_pengumumanController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pengumuman tidak boleh kosong"),
                    ),
                  );
                  return;
                }
                Navigator.pop(context);
                _pengumumanController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text("Unggah"),
            ),
          ],
        );
      },
    );
  }

  void _showPresensiModal(Map<String, String> data) {
    DateTime selectedDate = DateTime.now();
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    final TextEditingController topikController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: AlertDialog(
            backgroundColor: AppColors.surface,
            surfaceTintColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(
              "Presensi Kelas",
              style: AppTextStyles.itemTitle.copyWith(color: AppColors.primary),
            ),
            content: SizedBox(
              width: 420,
              child: StatefulBuilder(
                builder: (context, setModalState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _infoRow(
                        "Mata Kuliah",
                        "${data['nama']} (${data['kelas']})",
                      ),
                      _infoRow("SKS", data['sks']!),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 120, child: Text("Tanggal")),
                          const Text(": "),
                          InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setModalState(() => selectedDate = picked);
                              }
                            },
                            child: Container(
                              width: 170,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                border: Border.all(
                                  color: AppColors.lightActive,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "${selectedDate.day.toString().padLeft(2, '0')}/"
                                "${selectedDate.month.toString().padLeft(2, '0')}/"
                                "${selectedDate.year}",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                            child: Text("Waktu Presensi"),
                          ),
                          const Text(": "),
                          _timeBox(
                            context,
                            startTime,
                            (t) => setModalState(() => startTime = t),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("-"),
                          ),
                          _timeBox(
                            context,
                            endTime,
                            (t) => setModalState(() => endTime = t),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 120, child: Text("Topik")),
                          const Text(": "),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.lightActive,
                                ),
                              ),
                              child: TextField(
                                controller: topikController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  hintText:
                                      "Tuliskan topik perkuliahan di sini..",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text("Unggah"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(label)),
          const Text(": "),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _timeBox(
    BuildContext context,
    TimeOfDay? time,
    Function(TimeOfDay) onPick,
  ) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.inputOnly,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(alwaysUse24HourFormat: true),
              child: child!,
            );
          },
        );

        if (picked != null) onPick(picked);
      },
      child: Container(
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          time == null
              ? "12:00"
              : time.hour.toString().padLeft(2, '0') +
                    ":" +
                    time.minute.toString().padLeft(2, '0'),
        ),
      ),
    );
  }
}
