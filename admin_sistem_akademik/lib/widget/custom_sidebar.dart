import 'package:flutter/material.dart';
import 'package:admin_sistem_akademik/theme/design_system.dart';

// Import halaman-halaman Anda di sini
import 'package:admin_sistem_akademik/screen/dashboard_page.dart';
import 'package:admin_sistem_akademik/screen/kelas_page.dart';
import 'package:admin_sistem_akademik/screen/profil_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  bool _isSidebarVisible = true;

  final List<Widget> _pages = [
    const DashboardPage(),
    const KelasPage(),
    const ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () {
            if (isMobile) {
              Scaffold.of(context).openDrawer();
            } else {
              setState(() => _isSidebarVisible = !_isSidebarVisible);
            }
          },
        ),
        actions: [
          _buildAppBarProfile(),
          const SizedBox(width: AppSpacing.lg),
        ],
        shape: const Border(
          bottom: BorderSide(color: AppColors.lightActive, width: 1),
        ),
      ),
      drawer: isMobile ? Drawer(child: _buildSidebarContent(true)) : null,
      body: Row(
        children: [
          if (!isMobile && _isSidebarVisible)
            Container(
              width: 260,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(
                  right: BorderSide(color: AppColors.lightActive, width: 1),
                ),
              ),
              child: _buildSidebarContent(false),
            ),
          Expanded(
            child: IndexedStack(index: _selectedIndex, children: _pages),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarProfile() {
    return InkWell(
      onTap: () {
        setState(() => _selectedIndex = 2); 
      },
      borderRadius: BorderRadius.circular(AppRadius.button),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Elvira Rosa',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.lightActive,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 1.5),
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.primary,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarContent(bool isMobile) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppRadius.card / 2),
                ),
                child: const Icon(
                  Icons.school,
                  color: AppColors.textOnPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              const Text(
                'ADMIN SIAM',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        _buildSidebarItem(0, Icons.grid_view_rounded, "Dashboard", isMobile),
        _buildSidebarItem(1, Icons.book_rounded, "Kelas", isMobile),
        _buildSidebarItem(2, Icons.person_rounded, "Profil", isMobile),
        const Spacer(),
        _buildLogoutButton(),
      ],
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String label, bool isMobile) {
    bool isSelected = _selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);
          if (isMobile) Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withValues(alpha:0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? AppColors.primary : AppColors.textDisabled,
              ),
              const SizedBox(width: AppSpacing.lg),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: InkWell(
        onTap: () {
          // Logika Sign Out Firebase Anda di sini
        },
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
          child: Row(
            children: [
              const Icon(Icons.logout_rounded, color: AppColors.error, size: 22),
              const SizedBox(width: AppSpacing.lg),
              const Text(
                "Logout",
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}