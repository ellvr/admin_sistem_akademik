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
      "jadwal": "Senin • 10:30–12:10",
      "nama": "Perancangan Pengalaman Pengguna",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Selasa • 10:30–12:10",
      "nama": "Multimodal Storytelling",
      "kode": "CSD60711",
      "kelas": "B",
      "ruang": "Gedung F - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Rabu • 10:30–12:10",
      "nama": "Sistem Belajar Mesin",
      "kode": "CSD60711",
      "kelas": "E",
      "ruang": "Gedung F - F3.11",
      "prodi": "Sistem Informasi",
    },
    {
      "jadwal": "Kamis • 10:30–12:10",
      "nama": "Interaksi Manusia Komputer",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F - F3.11",
      "prodi": "Pendidikan TI",
    },
    {
      "jadwal": "Jum'at • 10:30–12:10",
      "nama": "Data Mining",
      "kode": "CSD60711",
      "kelas": "A",
      "ruang": "Gedung F - F3.11",
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

  @override
  Widget build(BuildContext context) {
    if (_showDetail && _selectedKelas != null) {
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_buildSearchBox()],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildScrollableTable(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableTable() {
    final filteredData = displayedData.where((e) {
      final name = e['nama']?.toLowerCase() ?? "";
      final code = e['kode']?.toLowerCase() ?? "";
      return name.contains(searchQuery) || code.contains(searchQuery);
    }).toList();

    return Container(
      height: 360,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Column(
          children: [
            _tableHeader(),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: 1050,
                    child: SingleChildScrollView(
                      child: Table(
                        columnWidths: const {
                          0: FlexColumnWidth(1.6),
                          1: FlexColumnWidth(2.8),
                          2: FlexColumnWidth(1.6),
                          3: FlexColumnWidth(1.2),
                          4: FlexColumnWidth(0.8),
                          5: FlexColumnWidth(1.6),
                          6: FlexColumnWidth(2.2),
                        },
                        border: TableBorder.symmetric(
                          inside: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.15),
                          ),
                        ),
                        children: filteredData.map((data) {
                          return TableRow(
                            children: [
                              _cell(data['jadwal']!),
                              _cell(data['nama']!),
                              _cell(data['prodi']!),
                              _cell(data['kode']!),
                              _cell(data['kelas']!, align: TextAlign.center),
                              _cell(data['ruang']!),
                              _actionCell(data),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 1050,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.6),
            1: FlexColumnWidth(2.8),
            2: FlexColumnWidth(1.6),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(0.8),
            5: FlexColumnWidth(1.6),
            6: FlexColumnWidth(2.2),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: AppColors.lightActive),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        alignment: WrapAlignment.center,
        children: [
          _miniActionBtn("Presensi", AppColors.primary, () {}),
          _miniActionBtn("Pengumuman", Colors.orange, () {}),
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
          border: Border.all(color: color.withValues(alpha: 0.5)),
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
          SizedBox(width: 120, child: Text(label)),
          const Text(" :  "),
          Expanded(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return SizedBox(
      width: 250,
      height: 38,
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => searchQuery = val.toLowerCase()),
        decoration: const InputDecoration(
          hintText: "Cari mata kuliah...",
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
