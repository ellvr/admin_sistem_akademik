import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

import 'detail_kelas_page.dart';

class KelasPage extends StatefulWidget {
  const KelasPage({super.key});

  @override
  State<KelasPage> createState() => _KelasPageState();
}

class _KelasPageState extends State<KelasPage> {
  // State Navigasi Internal
  bool _showDetail = false;
  Map<String, String>? _selectedKelas;

  // State Filter & Form
  String selectedFakultas = "Ilmu Komputer";
  String selectedDepartemen = "Sistem Informasi";
  String selectedProdi = "Sistem Informasi";
  String searchQuery = "";
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 30);
  TimeOfDay endTime = const TimeOfDay(hour: 12, minute: 10);

  List<Map<String, String>> displayedData = [];
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<String>> menuData = {
    "Informatika": ["Teknik Komputer", "Teknik Informatika", "Semua"],
    "Sistem Informasi": [
      "Sistem Informasi",
      "Pendidikan TI",
      "Teknologi Informasi",
      "Semua",
    ],
    "Semua": ["Semua"],
  };

  final List<Map<String, String>> allData = [
    {
      "jadwal": "Senin,\n10:30:00 - 12:10:00",
      "nama": "Perancangan Pengalaman Pengguna",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F\nFILKOM - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Selasa,\n10:30:00 - 12:10:00",
      "nama": "Multimodal Storytelling",
      "kode": "CSD60711",
      "kelas": "B",
      "ruang": "Gedung F\nFILKOM - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Rabu,\n10:30:00 - 12:10:00",
      "nama": "Sistem Belajar Mesin",
      "kode": "CSD60711",
      "kelas": "E",
      "ruang": "Gedung F\nFILKOM - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Kamis,\n10:30:00 - 12:10:00",
      "nama": "Interaksi Manusia Komputer",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F\nFILKOM - F3.11",
      "prodi": "Pendidikan TI",
    },
    {
      "jadwal": "Jum'at,\n10:30:00 - 12:10:00",
      "nama": "Data Mining",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F\nFILKOM - F3.11",
      "prodi": "Sistem Informasi",
    },
  ];

  @override
  void initState() {
    super.initState();
    displayedData = List.from(allData);
  }

  void _filterData() {
    setState(() {
      displayedData = allData.where((element) {
        bool matchesProdi =
            selectedProdi == "Semua" || element['prodi'] == selectedProdi;
        return matchesProdi;
      }).toList();
    });
  }

  Future<void> _handleUpload(String type) async {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$type berhasil diunggah!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  if (_showDetail && _selectedKelas != null) {
    // Memanggil CLASS beda file
    return DetailKelasPage(
      data: _selectedKelas!,
      onBack: () => setState(() => _showDetail = false),
    );
  }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Daftar Kelas', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child: _buildCompactFilters(),
            ),
            const SizedBox(height: AppSpacing.xl),
            Container(
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
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_buildSearchBox()],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: _buildModernShadowTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dropdownRow(
          "Fakultas",
          selectedFakultas,
          ["Ilmu Komputer", "Teknik", "Semua"],
          (val) => setState(() => selectedFakultas = val!),
        ),
        _dropdownRow(
          "Departemen",
          selectedDepartemen,
          ["Sistem Informasi", "Informatika", "Semua"],
          (val) {
            setState(() {
              selectedDepartemen = val!;
              selectedProdi = menuData[val]!.first;
            });
          },
        ),
        _dropdownRow(
          "Program Studi",
          selectedProdi,
          menuData[selectedDepartemen]!,
          (val) => setState(() => selectedProdi = val!),
        ),
        const SizedBox(height: AppSpacing.sm),
        Padding(
          padding: const EdgeInsets.only(left: 130),
          child: ElevatedButton(
            onPressed: _filterData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text("Tampilkan", style: TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }

  Widget _dropdownRow(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: AppTextStyles.bodyText),
          ),
          const Text(" :  "),
          Expanded(
            child: Container(
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.lightActive),
                borderRadius: BorderRadius.circular(4),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                  ),
                  items: items
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
        ],
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
            style: const TextStyle(fontSize: 14),
            onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
            decoration: const InputDecoration(
              hintText: "Cari mata kuliah...",
              fillColor: AppColors.background,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightActive),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.lightActive),
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
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: const Text("Cari"),
          ),
        ),
      ],
    );
  }

  Widget _buildModernShadowTable() {
    final filteredData = (displayedData).where((e) {
      final name = e['nama']?.toLowerCase() ?? "";
      final code = e['kode']?.toLowerCase() ?? "";
      return name.contains(searchQuery) || code.contains(searchQuery);
    }).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(2.2),
            2: FlexColumnWidth(1.4),
            3: FlexColumnWidth(0.8),
            4: FlexColumnWidth(0.6),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(2.4),
          },
          border: TableBorder(
            verticalInside: BorderSide(
              color: Colors.grey.withValues(alpha:0.2),
              width: 1,
            ),
            horizontalInside: BorderSide(
              color: Colors.grey.withValues(alpha:0.1),
              width: 1,
            ),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.lightActive),
              children: [
                _cell("Jadwal", isHeader: true),
                _cell("Nama MK", isHeader: true),
                _cell("Program Studi", isHeader: true),
                _cell("Kode MK", isHeader: true),
                _cell("Kelas", isHeader: true),
                _cell("Ruang", isHeader: true),
                _cell("Aksi", isHeader: true),
              ],
            ),
            ...filteredData.map((data) {
              return TableRow(
                children: [
                  _cell(data['jadwal'] ?? "-"),
                  _cell(data['nama'] ?? "-"),
                  _cell(data['prodi'] ?? "-"),
                  _cell(data['kode'] ?? "-"),
                  _cell(data['kelas'] ?? "-", align: TextAlign.center),
                  _cell(data['ruang'] ?? "-"),
                  _actionCell(data),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _cell(
    String text, {
    bool isHeader = false,
    TextAlign align = TextAlign.start,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontSize: isHeader ? 14 : 13,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _actionCell(Map<String, String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _miniActionBtn(
            "Presensi",
            AppColors.primary,
            () => _showPresensiModal(data['nama'] ?? "", data['prodi'] ?? ""),
          ),
          _miniActionBtn(
            "Pengumuman",
            Colors.orange,
            () => _showPengumumanModal(data['nama'] ?? ""),
          ),
          _miniActionBtn("Lihat", AppColors.textDisabled, () {
            setState(() {
              _selectedKelas = data;
              _showDetail = true;
            });
          }),
        ],
      ),
    );
  }

  Widget _miniActionBtn(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha:0.5)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: color == AppColors.textDisabled
                ? AppColors.textPrimary
                : color,
          ),
        ),
      ),
    );
  }

  void _showPengumumanModal(String mkTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text(
          "Pengumuman Kelas",
          style: AppTextStyles.itemTitle.copyWith(color: AppColors.primary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.lightActive),
              ),
              child: const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Tuliskan pengumuman untuk mata kuliah ini...",
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white, // Background putih
              side: const BorderSide(color: AppColors.primary), // Outline biru
              foregroundColor: AppColors.primary, // Tulisan biru
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () => _handleUpload("Pengumuman"),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text("Unggah", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPresensiModal(String mkTitle, String prodi) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return AlertDialog(
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(
              "Presensi Kelas",
              style: AppTextStyles.itemTitle.copyWith(color: AppColors.primary),
            ),
            content: SizedBox(
              width: 450,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _modalRow("Mata Kuliah", mkTitle, setModalState),
                  _modalRow("Program Studi", prodi, setModalState),
                  _modalRow(
                    "Tanggal",
                    "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                    setModalState,
                    isPicker: true,
                  ),
                  _modalRow("Waktu Presensi", "", setModalState, isTime: true),
                  const SizedBox(height: 12),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Topik :",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.lightActive),
                    ),
                    child: const TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText: "Tuliskan topik materi hari ini",
                        contentPadding: EdgeInsets.all(10),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white, // Background putih
                  side: const BorderSide(
                    color: AppColors.primary,
                  ), // Outline biru
                  foregroundColor: AppColors.primary, // Tulisan biru
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () => _handleUpload("Presensi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  "Unggah",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _modalRow(
    String label,
    String value,
    StateSetter setModalState, {
    bool isPicker = false,
    bool isTime = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(fontSize: 13)),
          ),
          const Text(" : "),
          const SizedBox(width: 10),
          if (isPicker)
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2101),
                );
                if (picked != null) setModalState(() => selectedDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.lightActive),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Text(value, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
            )
          else if (isTime)
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: startTime,
                    );
                    if (picked != null) setModalState(() => startTime = picked);
                  },
                  child: _timeBox(startTime.format(context)),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Text("-"),
                ),
                InkWell(
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: endTime,
                    );
                    if (picked != null) setModalState(() => endTime = picked);
                  },
                  child: _timeBox(endTime.format(context)),
                ),
              ],
            )
          else
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _timeBox(String time) {
    return Container(
      width: 70,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightActive),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(child: Text(time, style: const TextStyle(fontSize: 13))),
    );
  }

  // WIDGET DETAIL PAGE INTERNAL
  // Widget _buildDetailPage() {
  //   return Scaffold(
  //     backgroundColor: AppColors.background,
  //     body: Padding(
  //       padding: const EdgeInsets.all(AppSpacing.xxl),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             children: [
  //               IconButton(
  //                 icon: const Icon(Icons.arrow_back),
  //                 onPressed: () => setState(() => _showDetail = false),
  //               ),
  //               Text(
  //                 'Detail Kelas: ${_selectedKelas?['nama']}',
  //                 style: AppTextStyles.sectionTitle,
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 20),
  //           Container(
  //             padding: const EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: Text(
  //               "Isi detail kelas untuk ${_selectedKelas?['nama']} di sini...",
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
