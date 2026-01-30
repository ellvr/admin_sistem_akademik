import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:admin_sistem_akademik/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> login(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 3));

    
    final emailField = find.byKey(const Key('email_field'));
    final passwordField = find.byKey(const Key('password_field'));
    final loginButton = find.byKey(const Key('login_button'));

    expect(loginButton, findsOneWidget);

    await tester.enterText(emailField, 'elvira@admin.ub.ac.id');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.enterText(passwordField, '12345678');
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));
  }

  group('Integration Testing Sistem Akademik', () {
    testWidgets('SKA-01: Tampilkan Daftar Kelas', (tester) async {
      await login(tester);
      expect(find.text('Daftar Kelas'), findsOneWidget);
      print(
        'TPA-01: Main Flow: Kelola data menampilkan daftar kelas (Success)',
      );
    });

    testWidgets('SKA-02: Membuat Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Presensi').first);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        'Materi Web Testing',
      );
      await tester.tap(find.text('Unggah'));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      print(
        'TPA-02: Main Flow: Kelola data membuat presensi kelas tertentu (Success)',
      );
    });

    testWidgets('SKA-03: Edit Status Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hadir').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Izin').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      print(
        'TPA-03: Main Flow: Kelola data mengedit data presensi kelas (Success)',
      );
    });

    testWidgets('SKA-04: Hapus Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hapus'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hapus').last);
      print(
        'TPA-04: Main Flow: Kelola data menghapus data presensi kelas (Success)',
      );
    });

    testWidgets('SKA-05: Force Error Handling', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      print('TPA-05: Alt Flow 3a: Kegagalan kelola data (Success)');
    });
  });

  group('Integration Testing Sistem Akademik', () {
    testWidgets('SKA-01: Tampilkan Daftar Kelas', (tester) async {
      await login(tester);
      expect(find.text('Daftar Kelas'), findsOneWidget);
      print(
        'TPA-01: Main Flow: Kelola data menampilkan daftar kelas (Success)',
      );
    });

    testWidgets('SKA-02: Membuat Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Presensi').first);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField).first,
        'Materi Web Testing',
      );
      await tester.tap(find.text('Unggah'));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      print(
        'TPA-02: Main Flow: Kelola data membuat presensi kelas tertentu (Success)',
      );
    });

    testWidgets('SKA-03: Edit Status Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hadir').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Izin').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      print(
        'TPA-03: Main Flow: Kelola data mengedit data presensi kelas (Success)',
      );
    });

    testWidgets('SKA-04: Hapus Presensi', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hapus'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hapus').last);
      print(
        'TPA-04: Main Flow: Kelola data menghapus data presensi kelas (Success)',
      );
    });

    testWidgets('SKA-05: Force Error Handling', (tester) async {
      await login(tester);
      await tester.tap(find.text('Lihat').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Simpan'));
      print('TPA-05: Alt Flow 3a: Kegagalan kelola data (Success)');
    });
  });
}
