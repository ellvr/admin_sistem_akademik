import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

class DetailKelasPage extends StatefulWidget {
  final Map<String, String> data;
  final VoidCallback onBack;

  const DetailKelasPage({super.key, required this.data, required this.onBack});

  @override
  State<DetailKelasPage> createState() => _DetailKelasPageState();
}

class _DetailKelasPageState extends State<DetailKelasPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _isLoading = false;

  String _selectedTanggalPresensi = "28 Jan 2026";
  final List<String> _riwayatTanggal = [
    "28 Jan 2026",
    "21 Jan 2026",
    "14 Jan 2026",
    "07 Jan 2026",
  ];

  late List<Map<String, dynamic>> _currentMahasiswa;

  @override
  void initState() {
    super.initState();
    _currentMahasiswa = _generateInitialData();
  }

  List<Map<String, dynamic>> _generateInitialData() {
    return [
      {
        "no": "1",
        "nim": "235150600111001",
        "nama": "Adam Malik",
        "status": "Hadir",
        "rekap": {"H": 10, "I": 0, "A": 0, "S": 0},
        "persen": "100%",
      },
      {
        "no": "2",
        "nim": "235150600111002",
        "nama": "Budi Santoso",
        "status": "Alfa",
        "rekap": {"H": 9, "I": 0, "A": 1, "S": 0},
        "persen": "90%",
      },
      {
        "no": "3",
        "nim": "235150600111003",
        "nama": "Citra Lestari",
        "status": "Izin",
        "rekap": {"H": 8, "I": 2, "A": 0, "S": 0},
        "persen": "80%",
      },
      {
        "no": "4",
        "nim": "235150600111004",
        "nama": "Dedi Kurniawan",
        "status": "Hadir",
        "rekap": {"H": 10, "I": 0, "A": 0, "S": 0},
        "persen": "100%",
      },
      {
        "no": "5",
        "nim": "235150600111005",
        "nama": "Eka Putri",
        "status": "Sakit",
        "rekap": {"H": 7, "I": 0, "A": 0, "S": 3},
        "persen": "70%",
      },
      {
        "no": "6",
        "nim": "235150600111006",
        "nama": "Farhan Ghani",
        "status": "Hadir",
        "rekap": {"H": 10, "I": 0, "A": 0, "S": 0},
        "persen": "100%",
      },
      {
        "no": "7",
        "nim": "235150600111007",
        "nama": "Gita Permata",
        "status": "Hadir",
        "rekap": {"H": 10, "I": 0, "A": 0, "S": 0},
        "persen": "100%",
      },
      {
        "no": "8",
        "nim": "235150600111008",
        "nama": "Hadi Wijaya",
        "status": "Alfa",
        "rekap": {"H": 9, "I": 0, "A": 1, "S": 0},
        "persen": "90%",
      },
    ];
  }

  Future<void> _switchTanggal(String newTanggal) async {
    setState(() {
      _isLoading = true;
      _selectedTanggalPresensi = newTanggal;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      for (var m in _currentMahasiswa) {
        final statuses = ["Hadir", "Alfa", "Izin", "Sakit"];
        m['status'] = (statuses..shuffle()).first;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredMahasiswa = _currentMahasiswa.where((m) {
      return m['nama'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          m['nim'].contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: widget.onBack,
                    ),
                    const SizedBox(width: 8),
                    const Text('Presensi', style: AppTextStyles.sectionTitle),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildHeaderInfo(),
                const SizedBox(height: AppSpacing.xl),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTanggalSelector(),
                            _buildSearchSection(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: _buildPresensiTable(filteredMahasiswa),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Overlay Loading
          if (_isLoading)
            Container(
              color: Colors.white.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTanggalSelector() {
    return Row(
      children: [
        const Text(
          "Tanggal Kelas : ",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 8),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.lightActive),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedTanggalPresensi,
              icon: const Icon(Icons.keyboard_arrow_down, size: 18),
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (String? newValue) {
                if (newValue != null && newValue != _selectedTanggalPresensi) {
                  _switchTanggal(newValue);
                }
              },
              items: _riwayatTanggal.map<DropdownMenuItem<String>>((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderInfo() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          _infoRow("Mata Kuliah", widget.data['nama'] ?? "-"),
          _infoRow("Program Studi", "Magister Sistem Informasi"),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: AppTextStyles.bodyText),
          ),
          const Text(" :  "),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        SizedBox(
          width: 200,
          height: 35,
          child: TextField(
            controller: _searchController,
            onChanged: (val) => setState(() => _searchQuery = val),
            style: const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: "Cari mahasiswa...",
              fillColor: AppColors.background,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColors.lightActive),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColors.lightActive),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 0,
          ),
          child: const Text(
            "Cari",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPresensiTable(List<Map<String, dynamic>> data) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(0.3),
            1: FlexColumnWidth(1.3),
            2: FlexColumnWidth(1.8),
            3: FlexColumnWidth(1.0),
            4: FlexColumnWidth(2.5),
            5: FlexColumnWidth(0.4),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.lightActive),
              children: [
                _cell("No", isHeader: true, align: TextAlign.center),
                _cell("NIM", isHeader: true, align: TextAlign.center),
                _cell("Nama Mahasiswa", isHeader: true),
                _cell("Status", isHeader: true, align: TextAlign.center),
                _cell(
                  "Rekap Kehadiran",
                  isHeader: true,
                  align: TextAlign.center,
                ),
                _cell("%", isHeader: true, align: TextAlign.center),
              ],
            ),
            ...data
                .map(
                  (m) => TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    children: [
                      _cell(m['no'], align: TextAlign.center),
                      _cell(m['nim'], align: TextAlign.center),
                      _cell(m['nama']),
                      _statusDropdownMinimalist(m),
                      _buildModernRekap(m['rekap']),
                      _cell(
                        m['persen'],
                        align: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                )
                ,
          ],
        ),
      ),
    );
  }

  Widget _statusDropdownMinimalist(Map<String, dynamic> student) {
    Color getBgColor(String s) => s == "Hadir"
        ? const Color(0xFFE8F5E9)
        : s == "Alfa"
        ? const Color(0xFFFFEBEE)
        : s == "Izin"
        ? const Color(0xFFFFF3E0)
        : const Color(0xFFE3F2FD);
    Color getTextColor(String s) => s == "Hadir"
        ? Colors.green[700]!
        : s == "Alfa"
        ? Colors.red[700]!
        : s == "Izin"
        ? Colors.orange[800]!
        : Colors.blue[700]!;

    return Center(
      child: Container(
        height: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: getBgColor(student['status']),
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: student['status'],
            icon: Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: getTextColor(student['status']),
            ),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: getTextColor(student['status']),
            ),
            items: ["Hadir", "Alfa", "Izin", "Sakit"]
                .map<DropdownMenuItem<String>>(
                  (s) => DropdownMenuItem(value: s, child: Text(s)),
                )
                .toList(),
            onChanged: (val) => setState(() => student['status'] = val),
          ),
        ),
      ),
    );
  }

  Widget _buildModernRekap(Map<String, int> r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        children: [
          _rekapBadge("Hadir", r['H'].toString(), Colors.green),
          _rekapBadge("Izin", r['I'].toString(), Colors.orange),
          _rekapBadge("Alfa", r['A'].toString(), Colors.red),
          _rekapBadge("Sakit", r['S'].toString(), Colors.blue),
        ],
      ),
    );
  }

  Widget _rekapBadge(String l, String v, Color c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$l:",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: c,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            v,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: c,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cell(
    String t, {
    bool isHeader = false,
    TextAlign align = TextAlign.start,
    double fontSize = 13,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        t,
        textAlign: align,
        style: TextStyle(
          fontSize: isHeader ? 13 : fontSize,
          fontWeight: isHeader ? FontWeight.bold : fontWeight,
          color: isHeader ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
