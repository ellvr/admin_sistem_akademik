import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final TextEditingController _namaLengkapController = TextEditingController(text: "Elvira Rosa");
  final TextEditingController _tempatLahirController = TextEditingController(text: "Malang");
  final TextEditingController _alamatController = TextEditingController(text: "Jl. Ijen No.46 Kota Malang");
  
  bool _isSaving = false;

  Future<void> _handleSave() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Biodata berhasil diperbarui!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Profil', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.xl),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BAGIAN KIRI: RINGKASAN PROFIL
                    Expanded(flex: 1, child: _buildProfileCard()),
                    const SizedBox(width: AppSpacing.xl),
                    
                    // BAGIAN KANAN: FORMULIR BIODATA
                    Expanded(flex: 2, child: _buildBiodataForm()),
                  ],
                ),
              ],
            ),
          ),
          if (_isSaving)
            Container(
              color: Colors.black.withValues(alpha:0.1),
              child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
      ),
      child: Column(
        children: [
          // FOTO PROFIL VERSI KOTAK (Sesuai Wireframe)
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha:0.05),
              borderRadius: BorderRadius.circular(4), // Kotak dengan sedikit curve
              border: Border.all(color: Colors.grey.withValues(alpha:0.3), width: 1),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.person, size: 100, color: AppColors.primary),
                ),
                // Garis silang tipis ala placeholder wireframe (Opsional)
                CustomPaint(
                  size: const Size(180, 180),
                  
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          _infoProfilRow("Nama", "Elvira Rosa"),
          _infoProfilRow("NIP", "235150600111006"),
          _infoProfilRow("Email", "elvira@admin.ub.ac.id"),
          _infoProfilRow("Fakultas", "Ilmu Komputer"),
          _infoProfilRow("Department", "Sistem Informasi"),
          _infoProfilRow("Program Studi", "Sistem Informasi"),
          _infoProfilRow("Jabatan", "Dosen"),
          _infoProfilRow("Status", "Aktif", isStatus: true),
        ],
      ),
    );
  }

  Widget _buildBiodataForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha:0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Formulir Biodata", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          
          _formLabel("Nama Lengkap"),
          _buildTextField(_namaLengkapController),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Tempat Lahir"), _buildTextField(_tempatLahirController)])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Tanggal Lahir"), _buildTextField(TextEditingController(text: "05/05/1945"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Jenis Kelamin"), _buildTextField(TextEditingController(text: "Perempuan"))])),
            ],
          ),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Agama"), _buildTextField(TextEditingController(text: "Islam"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Golongan Darah"), _buildTextField(TextEditingController(text: "A"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Warga Negara"), _buildTextField(TextEditingController(text: "Indonesia"))])),
            ],
          ),
          
          const SizedBox(height: 16),
          _formLabel("Alamat"),
          _buildTextField(_alamatController),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Negara"), _buildTextField(TextEditingController(text: "Indonesia"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Propinsi"), _buildTextField(TextEditingController(text: "Jawa Timur"))])),
            ],
          ),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Kota"), _buildTextField(TextEditingController(text: "Malang"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Kode Pos"), _buildTextField(TextEditingController(text: "65432"))])),
            ],
          ),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("No.Hp"), _buildTextField(TextEditingController(text: "0987654321"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("Email"), _buildTextField(TextEditingController(text: "elvirarosa@gmail.com"))])),
            ],
          ),
          
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("NIK"), _buildTextField(TextEditingController(text: "354567899762452"))])),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_formLabel("NPWP"), _buildTextField(TextEditingController(text: "53527738"))])),
            ],
          ),
          
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              child: const Text("Simpan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return SizedBox(
      height: 38,
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }

  Widget _infoProfilRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey))),
          const Text(" : ", style: TextStyle(fontSize: 13)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isStatus ? Colors.green[700] : AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}