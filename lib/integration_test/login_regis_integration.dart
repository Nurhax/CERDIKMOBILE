import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tubes/login.dart';
import 'package:tubes/pilihRole.dart';
import 'package:tubes/registrasi_pasien.dart';
import 'package:tubes/registrasi_nakes.dart';
import 'package:tubes/pagePasien.dart';
import 'package:tubes/pageDokter.dart';

void main() {
  group('Login and Registration Integration Tests', () {
    testWidgets('Login screen renders correctly', (WidgetTester tester) async {
      // Build the login widget dengan ukuran layar yang lebih besar
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
                size: Size(1080,
                    1920)), // Ukuran layar yang lebih besar, sesuaikan dengan ukuran yang diinginkan
            child: Login(
              someCondition: true,
            ),
          ),
        ),
      );

      // Verifikasi elemen login muncul
      expect(find.text('Login'), findsOneWidget);
      expect(find.byType(TextField),
          findsAtLeast(2)); // Username dan password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Login button
      expect(find.text('Belum punya akun?'), findsOneWidget);
    });

    testWidgets('Navigation from Login to Registration works',
        (WidgetTester tester) async {
      // Build the login widget
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/pilihRole': (context) => Pilihrole(
                someCondition: true,
              ),
        },
        home: Login(
          someCondition: true,
        ),
      ));

      // Find and tap the registration link
      final registerLink = find.text('Daftar');
      expect(registerLink, findsOneWidget);
      await tester.tap(registerLink);
      await tester.pumpAndSettle();

      // Verify we're on the role selection page
      expect(find.byType(Pilihrole), findsOneWidget);
    });

    testWidgets('Role selection screen renders correctly',
        (WidgetTester tester) async {
      // Build the role selection widget
      await tester.pumpWidget(MaterialApp(
          home: Pilihrole(
        someCondition: true,
      )));

      // Verify role selection elements are present
      expect(find.text('Pilih Role'), findsOneWidget);
      expect(find.byType(GestureDetector),
          findsAtLeast(2)); // Role selection options
    });

    testWidgets('Navigation from Role Selection to Patient Registration works',
        (WidgetTester tester) async {
      // Build the role selection widget with routes
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/registrasi_pasien': (context) => RegistrasiPasien(
                someCondition: true,
              ),
        },
        home: Pilihrole(
          someCondition: true,
        ),
      ));

      // Find and tap the patient role option
      // Note: This is a simplified test. In a real test, you would need to find the specific
      // GestureDetector for the patient role, which might require more specific finders.
      final patientRoleOption = find.byType(GestureDetector).first;
      await tester.tap(patientRoleOption);
      await tester.pumpAndSettle();

      // Verify we're on the patient registration page
      expect(find.byType(RegistrasiPasien), findsOneWidget);
    });

    // Additional tests would follow similar patterns for:
    // - Navigation from Role Selection to Doctor Registration
    // - Form validation in registration screens
    // - Successful registration flow
    // - Successful login flow
  });
}
